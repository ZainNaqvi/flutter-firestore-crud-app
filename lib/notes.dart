import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/dialogbox.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('notes').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final list = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map notes = document.data()! as Map<String, dynamic>;
            list.add(notes);
            print(list);
          }).toList();
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 30, left: 60, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FIRESTORE",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.green[300],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Designed & Developed by Zain Naqvi",
                                  style: TextStyle(color: Colors.teal[700]),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Expanded(
                                child: TextButton(
                                  child: const Text(
                                    'ADD NOTE ',
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            DialogBox.alertDialog(context));
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  child: const Text(
                                    'SEARCH NOTE',
                                  ),
                                  onPressed: () {/* ... */},
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // read data from the database here...
                  for (var i = 0; i < list.length; i++) ...[
                    Card(
                      child: Column(children: [
                        ListTile(
                          leading: Icon(Icons.album),
                          title: Text(list[i]['title']),
                          subtitle: Text(list[i]['description']),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                child: Icon(Icons.edit),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                child:
                                    Icon(Icons.delete, color: Colors.red[200]),
                                onPressed: () {/* ... */},
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}