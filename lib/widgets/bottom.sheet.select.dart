import 'package:flutter/material.dart';

class BottomSheetSelect<T> extends StatelessWidget {
  final List<T> items;
  final T selected;
  final String title;
  final String Function(T) labelSelector;
  final void Function(T) onTap;
  BottomSheetSelect(
      {@required this.items,
      @required this.selected,
      @required this.title,
      @required this.labelSelector,
      @required this.onTap});
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 6,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('CLOSE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).cardColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: this.items.length,
              itemBuilder: (BuildContext _, int index) {
                return RadioListTile<T>(
                  groupValue: this.selected,
                  value: this.items[index],
                  title: Text(this.labelSelector(this.items[index])),
                  onChanged: (value) {
                    this.onTap(value);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
