import 'package:darkhold/models/models.dart';
import 'package:darkhold/sqlite.config.dart';
import 'package:darkhold/utils/common.utils.dart';
import 'package:darkhold/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'pages.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String username = 'Lijo Vijayan';
  Widget _renderContent(BuildContext _context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Good morning, $username !'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'CATEGORIES',
              style: Theme.of(_context).accentTextTheme.subtitle1,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext _context, int index) {
                return CategoreyCard(
                  categorey: '',
                  totalTaskCount: 25,
                  completedTasks: index,
                  progressColor: HexColor.fromHex('#FFFFFF'),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'TODAY\'S TASK',
              style: Theme.of(_context).accentTextTheme.subtitle1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 100,
              shrinkWrap: true,
              itemBuilder: (BuildContext _, int index) {
                print(index);
                return TaskCard(
                  completed: true,
                  id: index,
                  name: 'Random Task',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.bars),
            splashRadius: 20,
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search),
              splashRadius: 20,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.bell),
              splashRadius: 20,
              onPressed: () {},
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _renderContent(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(CupertinoIcons.plus),
          onPressed: () async {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: false,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return BottomSheetContainer();
              },
            );
          },
        ),
      ),
    );
  }
}

class BottomSheetContainer extends StatefulWidget {
  @override
  _BottomSheetContainerState createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: expanded ? MediaQuery.of(context).size.height : 200,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
          const Text('Modal BottomSheet'),
          ElevatedButton(
            child: const Text('Close BottomSheet'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
