import 'package:flutter/material.dart';

class AddCategoryPopup extends StatefulWidget {
  @override
  _AddCategoryPopupState createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  final _inputController = TextEditingController();
  bool _checked = true;

  void _onCheck(bool checked) {
    setState(() {
      _checked = checked;
    });
  }

  void _onSubmit() {
    final Map<String, dynamic> data = {
      'category': _inputController.value.text,
      'active': _checked,
    };
    Navigator.of(context).pop(data);
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
      title: const Text('Add Category'),
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
              controller: _inputController,
              decoration: InputDecoration(labelText: 'Category'),
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
                'Set as selected category',
                style: Theme.of(context).textTheme.bodyText2,
              ))
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: _onSubmit,
          textColor: Theme.of(context).primaryColor,
          child: const Text('ADD'),
        ),
      ],
    );
  }
}
