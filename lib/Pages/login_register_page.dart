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
bool withoutLogin = false;

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



Widget _submitButton() {
  return Container(
    width: double.infinity, // Setzen der Breite auf die maximale Breite
    child: ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    ),
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
        text: isLogin ? 'Don´t have a Account? Register here' : 'Already have a Account? Login here',
        style: TextStyle(
          color: Colors.white, // Schriftfarbe weiß
          decoration: TextDecoration.underline, // Unterstrich hinzufügen
        ),
      ),
    ),
  );
}


Widget _WhitoutLogin() {
  return TextButton(
    onPressed: () {
      setState(() {
        withoutLogin = !withoutLogin;
      });
    },
    child: RichText(
      text: TextSpan(
        text: 'Go on whitout Login ->',
        style: TextStyle(
          color: Colors.white, // Schriftfarbe weiß
          fontWeight: FontWeight.bold,
          fontSize: 20,
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
      centerTitle: true,
            title: Text(
        isLogin ? 'Login' : 'Register', // Moderne Überschrift für Anmeldung und Registrierung
       
        style: TextStyle(
          color: Colors.white, // Schriftfarbe der Überschrift
          fontWeight: FontWeight.bold,
          fontSize: 40,
          shadows: [
            Shadow(
              blurRadius: 6,
              color: Colors.white,
              offset: Offset(0, 0),
            ),
          ],
          fontFamily: 'Raleway', // Beispiel für eine moderne Schriftart (muss im pubspec.yaml definiert sein)
        ),
      ),
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
              _entryField('Email', _controllerEmail),
              _passwordField('Password', _controllerPassword),
              _errorMessage(),
              _submitButton(),
              _loginOrRegisterButton(),
              _WhitoutLogin(),
            ],
          ),
        ),
      ],
    ),
  );
}
}