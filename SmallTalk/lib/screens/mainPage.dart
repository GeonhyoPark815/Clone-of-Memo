import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            /// 상단 여백 (상태바)
            Container(
                child: Padding(padding: EdgeInsets.only(top: statusBarHeight))
            ),

            /// 공지 및 광고 배너
            /*
            Container(
              margin: EdgeInsets.only(bottom: 20.0),

              /// 구글 애드센스
              /// https://ssscool.tistory.com/384
              AdmobBanner(
                adUnitId: getBannerAdUnitId(),
                adSize: bannerSize,
                listener:
                    (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
              ),
            ),
            */
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),


      /// 하단
      /// https://material.io/components/bottom-navigation/flutter#theming-a-bottom-nav-bar
      /// https://security-nanglam.tistory.com/484

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        //Bar의 배경색
        selectedItemColor: Colors.white,
        //선택된 아이템의 색상
        unselectedItemColor: Colors.white.withOpacity(.60),
        //선택 안된 아이템의 색상
        selectedFontSize: 14,
        //선택된 아이템의 폰트사이즈
        unselectedFontSize: 14,
        //선택 안된 아이템의 폰트사이즈
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          //눌렀을 경우 어떻게 행동할지
          setState(() {
            //setState()를 추가하여 인덱스를 누를때마다 빌드를 다시함
            _selectedIndex = index; //index는 처음 아이템 부터 0, 1, 2, 3
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('Search'),
            icon: Icon(Icons.search_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('Add'),
            icon: Icon(Icons.add_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.account_box_outlined),
          ),
        ],
      ),
    );
  }

  List _widgetOptions = [
    Text(
      'Favorites',
      style: TextStyle(fontSize: 30,),
    ),
    Text(
      'Music',
      style: TextStyle(fontSize: 30,),
    ),
    Text(
      'Places',
      style: TextStyle(fontSize: 30,),
    ),
    Text(
      'News',
      style: TextStyle(fontSize: 30,),
    ),
  ];
}
