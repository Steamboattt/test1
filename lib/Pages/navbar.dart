import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class Navbar extends StatelessWidget {

  final User? user = Auth().currentUser;

  void getLocation() async{
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low);
    print("position");
    print(permission);
    print(position);
  }

  Widget _titel() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'Useremail not found');
  }

  Widget _userName() {
    return Text(user?.displayName ?? 'Username not found');
  }
    Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
          accountName: _userName(), 
          accountEmail: _userUid(),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(child: Image.asset('assets/StockPhoto.jpg')),
          ),
          decoration:const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: AssetImage('assets/FinnlandBackground.jpg'),fit: BoxFit.cover),
          ),
      ),

      ListTile( 
        leading:const  Icon(Icons.file_upload),
        title: const Text('upload shot'),
        onTap: () => print('Upload tapped'),
      ),

      ListTile( 
        leading:const  Icon(Icons.messenger),
        title: const Text('Messages'),
        onTap: () => print('Upload tapped'),
      ),

      ListTile( 
        leading:const  Icon(Icons.favorite),
        title: const Text('Favorits'),
        onTap: () => print('Upload tapped'),
      ),

      ListTile( 
        leading:const  Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () => print('Upload tapped'),
      ),
      
      ListTile( 
        leading:const  Icon(Icons.create),
        title: const Text('Create your Shop'),
        onTap: () => print('Upload tapped'),
      ),



ListTile(
  leading: const Icon(Icons.location_city),
  title: const Text('Get Location'),
  onTap: () {

  }
),

      ListTile( 
        leading:const  Icon(Icons.logout),
        title: const Text('Logout'),
        tileColor: Colors.red,
        onTap: () => (signOut(),)
      ),



        ],
      )
    );
  }
}