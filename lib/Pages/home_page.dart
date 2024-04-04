import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test1/Pages/navbar.dart';
import 'package:test1/auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'search_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  late LocationPermission permission;
  late Position position;
  late Placemark placemarks;
  String? city;
  String? street;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

 void getLocation() async {
    
    permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print("test");
      print(placemarks[0].name);
       city = placemarks[0].locality;
       street = placemarks[0].street;
    }catch(err){}

    setState(() {}); 
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userEmail() {
    return Text(user?.email ?? 'User email');
  }

  Widget _userName() {
    return Text(user?.displayName ?? 'User Name');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()), // Navigiere zur SearchPage
            );
          },
          child: Text(
            '${city ?? ""}${street ?? ""}' == "" ? "Unknown" : '${city ?? ""}${" "}${street ?? ""}${'▼'}',
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: getLocation,
              child: Text('Get Location'),
            ),
            // Weitere Widgets hier...
          ],
        ),
      ),
    );
  }
}