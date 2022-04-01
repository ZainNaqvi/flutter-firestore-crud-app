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
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              toolbarHeight: 40,
              backgroundColor:
                  // innerBoxIsScrolled == true ? Colors.green[300] : Colors.white
                  // ,
                  Colors.white,
              elevation: 1,
              snap: true,
              centerTitle: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              title: innerBoxIsScrolled == true
                  ? Text(
                      "TODO LIST",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : Text(""),
            )
          ],
          body: Notes(),
        ),
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
