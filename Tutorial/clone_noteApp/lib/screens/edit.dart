import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.save))
          ],
        ),
        body:
        Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  // 텍스트 스타일 적
                  keyboardType: TextInputType.multiline,
                  // 자동 줄바꿈
                  maxLines: null,
                  // 글의 줄 수 최대 제한 없음
                  //obscureText: true,
                  //비밀번호 등함 입력 내용 보호 기능 적용 안
                  decoration: InputDecoration(
                    hintText: '제목을 입력해주세요',
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  keyboardType: TextInputType.multiline,
                  // 자동 줄바꿈
                  maxLines: null,
                  // 글의 줄 수 최대 제한 없음
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
}
