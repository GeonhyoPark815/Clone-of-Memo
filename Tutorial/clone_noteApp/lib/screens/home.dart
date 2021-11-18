import 'package:clone_noteapp/screens/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit.dart';

import 'package:clone_noteapp/database/db.dart';
import 'package:clone_noteapp/database/memo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
            child: Container(
              child: Text('메모 clone',
                  style: TextStyle(fontSize: 36, color: Colors.blue)),
              alignment: Alignment.centerLeft,
            ),
          ),
          // Expanded
          // https://padro.tistory.com/162
          Expanded(child: memoBuilder(context))
        ],
      ),

      /*
      ListView(
        //용 행의 수가 많을 수 있어 Column의 사용은 부적절
        // 따라서 ListView 사용
        physics: BouncingScrollPhysics(),
        // 애니메이션 추가
        children: <Widget>[
        ...LoadMemo()],
    ),
         */

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => EditPage()))
              .then((value) {
            // setState() 사용법
            // https://terry1213.github.io/flutter/flutter-statefulwidget-setState/
            setState(() {});
          });
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: const Text('메모 추가'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> LoadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.redAccent,
      height: 100,
    ));
    return memoList;
  }

  // memo를 불러오는 함수
  // db.dart / DBHelper / memos
  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  // 삭제 경고 및 실행 기능
  // https://here4you.tistory.com/176
  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('실행 전 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteMemo(deleteID);
                  deleteID = "";
                });
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  // Future Builder Listview
  // https://medium.com/nonstopio/flutter-future-builder-with-list-view-builder-d7212314e8c9

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder(
      builder: (context, Snap) {
        // null로 판단하기는 불가능
        // 내용은 비었으나 null은 아님
        // 따라서 isEmpty 사용
        if ((Snap.data as List).isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const Text(
              '지금 바로 "메모 추가" 버튼을 눌러 새로운 메모를 추가해보세요.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          // 애니메이션 기능 추가
          // 추가 공부 필요 - 왜 ListView에 들어가는가?
          physics: BouncingScrollPhysics(),
          itemCount: (Snap.data as List).length,
          itemBuilder: (context, index) {
            Memo memo = (Snap.data as List)[index];
            // InkWell : 제스처 명령 가능
            return InkWell(
              // 1번 탭하면 이동
              onTap: () {},
              // 길게 누르면 삭제
              onLongPress: () {
                // showAlertDialog에서 memo.id 호출이 불가능
                deleteID = memo.id;
                showAlertDialog(parentContext);
              },
              child: Container(
                // margin : 외부와의 여백
                // padding : 내부의 여백
                // https://coding-factory.tistory.com/187

                // ui 사이즈가 맞지 않으면
                // body overflowed 오류가 나타남 - 추가 공부 필요
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 70,
                // https://api.flutter.dev/flutter/painting/BoxDecoration-class.html
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlue, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                // Widget to display the list of project
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            memo.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            memo.text,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "최종 수정 시간 : " + memo.editTime.split('.')[0],
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54),
                            textAlign: TextAlign.end,
                          )
                        ])
                  ],
                ),
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
