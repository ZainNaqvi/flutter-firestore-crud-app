import 'package:flutter/material.dart';

class DialogBox {
  static AlertDialog alertDialog(BuildContext context) => AlertDialog(
        title: const Text(
          'ADD NEW NOTE ',
          style: TextStyle(color: Colors.green),
        ),
        content: Container(
          height: 200.0,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Tag"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Description"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Add'),
            child: const Text('Add'),
          ),
        ],
      );
}
