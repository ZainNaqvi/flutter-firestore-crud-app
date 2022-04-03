import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/editnote.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool change = false;
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
                                  "TODO'S APP",
                                  style: TextStyle(
                                      fontSize: 55,
                                      color: Colors.blueGrey,
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
                                  child: Icon(Icons.note_add, size: 40),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/addnote');
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  child: change == false
                                      ? Icon(
                                          Icons.favorite_outline,
                                          size: 40,
                                          color: Colors.teal[500],
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: Colors.teal[500],
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Thank You! For like our App.'),
                                        ),
                                      );
                                      change = true;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    margin: EdgeInsets.only(top: 40, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "TODO'S LIST 🖍",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  // read data from the database here...
                  for (var i = 0; i < list.length; i++) ...[
                    Card(
                      color: Colors.blueGrey[600],
                      borderOnForeground: false,
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: Column(children: [
                        ListTile(
                          leading: Icon(
                            Icons.notes,
                            color: Colors.grey,
                          ),
                          trailing: Text(
                            "🤍 " + list[i]['tag'].toString().toUpperCase(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          title: Text(
                            list[i]['title'].toString().toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            list[i]['description'],
                            style: TextStyle(
                                color: Color.fromARGB(255, 252, 252, 252)),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Expanded(
                              child: TextButton(
                                child: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          UpdateStudentPage(id: list[i]['id']),
                                    ),
                                  );
                                },
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
