/// Standard Appbar Design
/// https://childcare-daddy.tistory.com/16

import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {Key? key,
      required this.appBar,
      required this.title,
      this.center = false})
      : super(key: key);

  final AppBar appBar;
  final String title;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // 뒤로가기 버튼 자동생성 X
      actions: [
        IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black45,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      titleSpacing: 16,
      centerTitle: center,
      // true : center, false : basic
      title: Text("$title", style: Theme.of(context).textTheme.subtitle1),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
