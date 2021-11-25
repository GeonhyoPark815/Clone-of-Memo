/// https://sudarlife.tistory.com/entry/flutter-firebase-auth-플러터-파이어베이스-연동-로그인을-구연해보자-part-1
/// Firebase 앱등록
/// https://console.firebase.google.com/u/0/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/screens/login/home.dart';

class ForFirebase extends StatelessWidget {
  const ForFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
