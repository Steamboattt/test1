import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:test1/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

final User? user = Auth().currentUser;

Future<void> signOut() async{
  await Auth().signOut();
}

Widget _titel(){
  return const Text('Firebase Auth');
}

Widget _userUid(){
  return Text(user?.email ?? 'User email');
}

Widget _signOutButton(){
  return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'),);
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _titel(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ],
        ),
      )
    );
  }
}