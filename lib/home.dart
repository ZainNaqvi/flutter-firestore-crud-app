import 'package:crudfirebase/notes.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: innerBoxIsScrolled == true
                  ? Colors.blueGrey[500]
                  : Colors.grey[50],
              elevation: 5,
              snap: true,
              centerTitle: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              title: innerBoxIsScrolled == true
                  ? Text(
                      "FLUTTER FIRESTORE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : Text(""),
            )
          ],
          body: Notes(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addnote');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
