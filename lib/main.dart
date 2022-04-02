import 'package:crudfirebase/addnote.dart';
import 'package:crudfirebase/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: ' AIzaSyAAqJ6RIUNVvuYxhmu4jsjB0DBaA5eGN7Y',
            appId: "1:528745810247:web:2755ea975d2b3a3d05e462",
            messagingSenderId: "528745810247",
            projectId: "fluttercrudapp-d906e"));
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          // check for the errors
          if (snapshot.hasError) {
            print("Something went wroung.");
          }
          // connected to success
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.teal,
              ),
              // home: const Home(),
              initialRoute: '/',
              routes: {
                '/': (context) => Home(),
                '/addnote': (context) => AddNote(),
              },
              debugShowCheckedModeBanner: false,
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
