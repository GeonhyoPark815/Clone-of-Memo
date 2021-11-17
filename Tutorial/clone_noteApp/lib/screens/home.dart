import 'package:clone_noteapp/screens/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        //용 행의 수가 많을 수 있어 Column의 사용은 부적
        // 따라서 ListView 사용
        physics: BouncingScrollPhysics(),
        // 애니메이션 추가
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text('메모메모',
                      style: TextStyle(fontSize: 36, color: Colors.blue))),
            ],
          ),

          /*
          Container(color: Colors.redAccent, height: 100,),
          Container(color: Colors.orange, height: 100,),
          Container(color: Colors.yellow, height: 100,),
          Container(color: Colors.green, height: 100,),
          Container(color: Colors.blue, height: 100,),
          Container(color: Colors.indigo, height: 100,),
          Container(color: Colors.purple, height: 100,)
          */

          ...LoadMemo()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '메를 추가하려면 클릭하세요',
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
}
