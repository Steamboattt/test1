import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
String? errorMessage = '';
bool isLogin = true;

final TextEditingController _controllerEmail = TextEditingController();
final TextEditingController _controllerPassword = TextEditingController();


Future<void> signInWithEmailAndPassword() async {
  try{
    await Auth().signInWithEmailAndPassword(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
  );
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
    });
  }
}


Future<void> createUserWithEmailAndPassword() async {
  try{
    await Auth().createUserWithEmailAndPassword(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );
  } on FirebaseAuthException catch(e){
    errorMessage = e.message;
  }
}

Widget _titel () {
  return const Text('Firebase Auth');
}

Widget _entryField(
  String title,
  TextEditingController controller,
){
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: title,
      labelStyle: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold), // Farbe des Labels ändernd

    ),
        style: TextStyle(color: Colors.white), // Farbe des eingegebenen Texts ändern

  );
}

Widget _passwordField(
  String title,
  TextEditingController controller,
){
  return TextField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      labelText: title,
      labelStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Farbe des Labels ändern
    ),
    style: TextStyle(color: Colors.white), // Farbe des eingegebenen Texts ändern
  );
}




Widget _errorMessage() {
  return errorMessage == null || errorMessage!.isEmpty
      ? Text('') // Wenn errorMessage null oder leer ist, wird ein leerer Text zurückgegeben
      : Text(
          'Error: $errorMessage',
          style: TextStyle(
            color: Colors.red, // Schriftfarbe rot
            fontWeight: FontWeight.bold,
            backgroundColor: Color.fromARGB(135, 0, 0, 0),
          ),
        );
}



Widget _submitButton(){
  return ElevatedButton(
    onPressed: isLogin? signInWithEmailAndPassword : createUserWithEmailAndPassword,
     child: Text(isLogin ? 'Login' : 'Register'),
     );
}

Widget _loginOrRegisterButton() {
  return TextButton(
    onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    },
    child: RichText(
      text: TextSpan(
        text: isLogin ? 'Register instead' : 'Login instead',
        style: TextStyle(
          color: Colors.white, // Schriftfarbe weiß
          decoration: TextDecoration.underline, // Unterstrich hinzufügen
        ),
      ),
    ),
  );
}


@override
Widget build(BuildContext context){
  return Scaffold(
    extendBodyBehindAppBar: true, // Damit das Hintergrundbild hinter der AppBar liegt
    appBar: AppBar(
      backgroundColor: Colors.transparent, // Transparente Hintergrundfarbe der AppBar
      elevation: 0, // Kein Schatten
      title: Text(
        isLogin ? 'Login' : 'Register',
        style: TextStyle(
          color: Colors.white, // Schriftfarbe der Überschrift
          fontWeight: FontWeight.bold,
          fontSize: 30, 
        ),
      ),
      centerTitle: true, // Zentrierte Überschrift
    ),
    body: Stack(
      children: [
        // Hintergrund
        Container(
          width: MediaQuery.of(context).size.width, // Breite des Bildschirms
          height: MediaQuery.of(context).size.height, // Höhe des Bildschirms
          child: Image(
            image: AssetImage('assets/FinnlandBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // Inhalt
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _entryField('email', _controllerEmail),
              _passwordField('password', _controllerPassword),
              _errorMessage(),
              _submitButton(),
              _loginOrRegisterButton()
            ],
          ),
        ),
      ],
    ),
  );
}
}