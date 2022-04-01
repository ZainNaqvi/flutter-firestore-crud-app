import 'package:crudfirebase/dialogbox.dart';
import 'package:crudfirebase/notes.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Notes(),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: new CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Container(
            height: 50.0,
            color: Colors.green[300],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    DialogBox.alertDialog(context));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
