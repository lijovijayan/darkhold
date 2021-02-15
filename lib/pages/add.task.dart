import 'package:darkhold/models/categorey.model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: expanded ? MediaQuery.of(context).size.height : 250,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              color: Colors.white,
              height: 20,
            ),
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    DropdownSearch<Categorey>(
                      validator: (v) => v == null ? "required field" : null,
                      hint: "Select a Categorey",
                      mode: Mode.MENU,
                      compareFn: (Categorey i, Categorey s) {
                        if (i != null && s != null) {
                          return i.id == s.id;
                        }
                        return false;
                      },
                      onChanged: (Categorey data) {
                        print(data.name);
                      },
                      popupItemBuilder: _selectboxItemBuilder,
                      dropdownBuilder: _dropdownBuilder,
                      showSelectedItem: true,
                      items: [
                        Categorey(
                          id: 0,
                          name: 'Catagorey 1',
                          color: 'red',
                          completedTasks: 0,
                          totalTasks: 0,
                        ),
                        Categorey(
                          id: 1,
                          name: 'Catagorey 2',
                          color: 'red',
                          completedTasks: 0,
                          totalTasks: 0,
                        ),
                        Categorey(
                          id: 2,
                          name: 'Catagorey 3',
                          color: 'red',
                          completedTasks: 0,
                          totalTasks: 0,
                        ),
                        Categorey(
                          id: 3,
                          name: 'Catagorey 4',
                          color: 'red',
                          completedTasks: 0,
                          totalTasks: 0,
                        ),
                        Categorey(
                          id: 4,
                          name: 'Catagorey 5',
                          color: 'red',
                          completedTasks: 0,
                          totalTasks: 0,
                        ),
                      ],
                      label: "Categorey",
                      showClearButton: true,
                    ),
                    TextFormField(),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _dropdownBuilder(
      BuildContext context, Categorey item, String itemDesignation) {
    return Container(
      child: (item?.id == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("No item selected"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(item.name),
            ),
    );
  }

  Widget _selectboxItemBuilder(
      BuildContext context, Categorey item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        selected: isSelected,
        title: Text(item.name),
      ),
    );
  }
}
