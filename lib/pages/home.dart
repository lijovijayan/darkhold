import '../utils/common.utils.dart';
import '../widgets/widgets.dart';
import './pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String username = 'Lijo Vijayan';
  void _onClickAddButton(context) async {
    // await CategoreyTable.insert(Categorey(
    //     color: 'red',
    //     completedTasks: 0,
    //     id: null,
    //     name: 'Categorey Test',
    //     totalTasks: 100));
    // await TaskTable.insert(Task(
    //   categoreyId: 2,
    //   color: 'red',
    //   id: null,
    //   completed: true,
    //   date: '12-05-1000',
    //   time: '12:05',
    //   name: 'Test Task'
    // ));
    // final cat = await CategoreyTable.getCategoreyById(1);
    // final cats = await CategoreyTable.getAllCategories();
    // final task = await TaskTable.getTasksByCategoreyId(1);
    // print(cat);
    // print(cats);
    // print(task);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddTaskPage();
      },
    );
  }

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
              itemCount: 10,
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
          onPressed: () => _onClickAddButton(context),
        ),
      ),
    );
  }
}
