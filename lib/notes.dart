import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  // creating the instance
  CollectionReference note = FirebaseFirestore.instance.collection('notes');
  // creating the delete function here...
  Future<void> deleteUser(noteId) async {
    return note.doc(noteId).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The note is deleted successfully from the databse.'),
        ),
      );
    }).catchError((error) => print("Failed to delete user: $error"));
  }

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
            notes['id'] = document.id;
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
                            margin: EdgeInsets.only(left: 60, bottom: 10),
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
                                  child: const Text('ADD NOTE',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/addnote');
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  child: const Text('SEARCH NOTE',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
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
                                onPressed: () => deleteUser(list[i]['id']),
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
