import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  static final _formKey = GlobalKey<FormState>();
  // variable for saving the data
  static var title = "";
  static var description = "";
  static var tag = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  static final titleController = TextEditingController();
  static final descriptionController = TextEditingController();
  static final tagController = TextEditingController();

  clearText() {
    titleController.clear();
    descriptionController.clear();
    tagController.clear();
  }

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('notes');
  Future<void> addNote() async {
    // Call the user's CollectionReference to add a new user
    return await users.add({
      'tag': tag, // John Doe
      'title': title, // Stokes and Sons
      'description': description // 42
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The note is added successfully in the databse.'),
        ),
      );
      Navigator.pop(context, 'Add');
    }).catchError((error) => print("Failed to add Note: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        elevation: 9.0,
        title: const Text(
          'ADD NEW NOTE ',
          style: TextStyle(color: Colors.green),
        ),
        content: Container(
          height: 250.0,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Tag"),
                  controller: tagController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Tag';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Title"),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Description"),
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Description.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  title = titleController.text;
                  tag = tagController.text;
                  description = descriptionController.text;
                  addNote();
                  clearText();
                });
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
