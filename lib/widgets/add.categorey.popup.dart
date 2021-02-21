import 'package:flutter/material.dart';

class AddCategoreyPopup extends StatefulWidget {
  @override
  _AddCategoreyPopupState createState() => _AddCategoreyPopupState();
}

class _AddCategoreyPopupState extends State<AddCategoreyPopup> {
  bool _checked = false;
  void _onCheck(bool checked) {
    setState(() {
      _checked = checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(
        left: 10,
        right: 25,
      ),
      actionsPadding: EdgeInsets.only(right: 15),
      backgroundColor: Theme.of(context).canvasColor,
      title: const Text('Add Categorey'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: 'Categorey'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Checkbox(
                value: _checked,
                onChanged: _onCheck,
              ),
              Expanded(
                  child: Text(
                'Set as selected categorey',
                style: Theme.of(context).textTheme.bodyText2,
              ))
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ADD'),
        ),
      ],
    );
  }
}