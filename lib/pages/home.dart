import 'package:darkhold/models/models.dart';
import 'package:darkhold/provider/category.provider.dart';
import 'package:darkhold/provider/task.provider.dart';
import 'package:provider/provider.dart';

import '../utils/common.utils.dart';
import '../widgets/widgets.dart';
import './pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;

  final String username = 'Lijo Vijayan';

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onClickAddButton(context) async {
    _animationController.forward().then((value) => {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            enableDrag: false,
            builder: (BuildContext context) {
              return AddTaskPage();
            },
          ).then((value) => {_animationController.reverse()})
        });
  }

  Widget _renderContent(BuildContext _context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Good morning,\n$username !',
              style: Theme.of(_context).primaryTextTheme.headline4,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'CATEGORIES',
              style: Theme.of(_context).primaryTextTheme.subtitle1,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 200,
            child: CategoryList(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'TODAY\'S TASK',
              style: Theme.of(_context).primaryTextTheme.subtitle1,
            ),
          ),
          TaskList(),
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
            icon: Icon(
              CupertinoIcons.bars,
              size: 28,
            ),
            splashRadius: 25,
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.search,
                size: 25,
              ),
              splashRadius: 25,
              onPressed: () {},
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.bell,
                size: 25,
              ),
              splashRadius: 25,
              onPressed: () {},
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _renderContent(context),
        floatingActionButton: FloatingActionButton(
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.25).animate(_animationController),
            child: Icon(CupertinoIcons.plus),
          ),
          onPressed: () => _onClickAddButton(context),
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  onTapTask(BuildContext context, MTask task, bool completed) {
    context.read<PTask>().updateTableTask(MTask(
        id: task.id,
        categoryId: task.categoryId,
        categoryName: task.categoryName,
        name: task.name,
        date: task.date,
        time: task.time,
        completed: completed,
        color: task.color));
    context
        .read<PCategory>()
        .updateCompletedTaskCountById(task.categoryId, completed);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child:
          Consumer(builder: (BuildContext _context, PTask task, Widget child) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: task.tasks.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext _, int index) {
              return TaskCard(
                completed: task.tasks[index].completed,
                id: task.tasks[index].id,
                name: task.tasks[index].name,
                color: HexColor.fromHex(task.tasks[index].color),
                onTap: (bool completed) {
                  onTapTask(context, task.tasks[index], completed);
                },
              );
            });
      }),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext _context, PCategory category, Widget child) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: category.categories.length,
        itemBuilder: (BuildContext _context, int index) {
          return CategoryCard(
            category: category.categories[index].name,
            totalTaskCount: category.categories[index].totalTasks,
            completedTasks: category.categories[index].completedTasks,
            progressColor: HexColor.fromHex(category.categories[index].color),
          );
        },
      );
    });
  }
}
