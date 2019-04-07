import 'package:flutter/material.dart';

class InputDialogs {

  static AlertDialog newTextInputDialog({@required BuildContext context, @required String title, String initialValue = '', String hint = '', ValueChanged<String> onSubmitted}) {
    TextEditingController textController = TextEditingController(text: initialValue);
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: hint),
          autofocus: true,
          // Not calling onSubmitted here because the user might click cancel
//          onSubmitted: onSubmitted,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () { Navigator.of(context).pop(); },
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: () { onSubmitted(textController.text) ; Navigator.of(context).pop(); },
        ),
      ],
    );
  }

}