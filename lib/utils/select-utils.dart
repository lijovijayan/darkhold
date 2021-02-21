import 'package:darkhold/models/models.dart';
import 'package:flutter/material.dart';

Widget dropdownBuilder(
    BuildContext context, Categorey item, String itemDesignation) {
  return Container(
    child: (item?.id == null)
        ? ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "Select Categorey",
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
          )
        : ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(item.name),
          ),
  );
}

Widget selectboxItemBuilder(
    BuildContext context, Categorey item, bool isSelected) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    decoration: !isSelected
        ? BoxDecoration(
            color: Theme.of(context).canvasColor,
          )
        : BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border.all(color: Theme.of(context).primaryColor),
            // borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(
      tileColor: Theme.of(context).canvasColor,
      contentPadding: EdgeInsets.all(0),
      selected: isSelected,
      title: Text(item.name),
    ),
  );
}
