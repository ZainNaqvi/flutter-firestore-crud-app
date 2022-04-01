import 'package:flutter/material.dart';

class DialogBox {
  static AlertDialog alertDialog(BuildContext context) => AlertDialog(
        title: const Text(
          'ADD NEW NOTE ',
          style: TextStyle(color: Colors.green),
        ),
        content: Column(
          children: [],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      );
}
