import 'package:darkhold/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNotesPage extends StatelessWidget {
  void _onClickMore(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) => NotesBottomSheet(
        selectedColor: Colors.red,
      ),
    ).then((value) async {
      if (value != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        splashRadius: 25,
                        icon: Icon(CupertinoIcons.ellipsis_vertical),
                        onPressed: () {
                          _onClickMore(context);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 4,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: TextField(
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                CheckboxList(),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Row(
              children: [
                IconButton(
                  splashRadius: 25,
                  icon: Icon(CupertinoIcons.checkmark_alt_circle),
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(CupertinoIcons.checkmark_alt_circle),
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(CupertinoIcons.checkmark_alt_circle),
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(CupertinoIcons.checkmark_alt_circle),
                  onPressed: () {},
                ),
                Expanded(
                  child: SizedBox(),
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(CupertinoIcons.doc),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxList extends StatefulWidget {
  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: AnimatedCheckBox(
            checked: checked,
            onChanged: (bool value) {
              setState(() {
                checked = value;
              });
            },
          ),
          title: TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}

class NotesBottomSheet extends StatefulWidget {
  final Color selectedColor;
  NotesBottomSheet({@required this.selectedColor});

  @override
  _NotesBottomSheetState createState() => _NotesBottomSheetState();
}

class _NotesBottomSheetState extends State<NotesBottomSheet> {
  int selectedIndex;
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11',
                  '12',
                  '13',
                  '14'
                ]
                    .asMap()
                    .map(
                      (i, element) => MapEntry(
                        i,
                        IconButton(
                          splashRadius: 25,
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: selectedIndex == i
                                  ? Icon(
                                      Icons.check,
                                      size: 20,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          onPressed: () {
                            print(i);
                            print(selectedIndex);
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.checkmark_alt_circle),
                    title: Text('Save note'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.trash),
                    title: Text('Delete note'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.doc_on_doc),
                    title: Text('Make a copy'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.share_outlined),
                    title: Text('Share'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
