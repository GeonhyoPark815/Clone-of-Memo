import 'package:clone_noteapp/database/db.dart';
import 'package:clone_noteapp/database/memo.dart';
import 'package:flutter/material.dart';

// sha256 사용
// flutter pub add crypto 실행
// https://pub.dev/packages/crypto/install
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class WritePage extends StatefulWidget {
  WritePage({Key? key, required this.id}) : super(key: key);
  final String id;


  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<WritePage> {
  late BuildContext _context;
  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.delete),
            onPressed: (){},),
            IconButton(
                icon: const Icon(Icons.save),
            onPressed: saveDB,)
          ],
        ),
        body:
        Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (String title) {
                    this.title = title;
                  },
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  // 텍스트 스타일 적
                  keyboardType: TextInputType.multiline,
                  // 자동 줄바꿈
                  maxLines: 2,
                  // 글의 최대 줄수 2
                  //obscureText: true,
                  //비밀번호 등함 입력 내용 보호 기능 적용 안
                  decoration: InputDecoration(
                    hintText: '제목을 입력해주세요',
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  onChanged: (String text) {
                    this.text = text;
                  },
                  keyboardType: TextInputType.multiline,
                  // 자동 줄바꿈
                  maxLines: null,
                  // 글의 줄 수 최대 제한 X
                  //obscureText: true,
                  //비밀번호 등함 입력 내용 보호 기능 적용 안
                  decoration: InputDecoration(
                    hintText: '내용을 입력해주세요',
                  ),
                ),
                //TextField()
              ],
            ),
        )

    );
  }

  Future<void> saveDB() async{
    DBHelper sd = DBHelper();

    var fido = Memo(
      // DateTime을 이용하여 암호화된 id 생
      id: Str2sha512(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
    Navigator.pop(_context);
  }

  // ID 암호
  String Str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
