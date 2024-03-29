import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/common.utils.dart';
import '../widgets/widgets.dart';
import './pages.dart';
import '../models/models.dart';
import '../provider/core.provider.dart';
import '../provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username = 'Lijo Vijayan';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
          TaskListTitle(),
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBarWithSearch(
              onOpenDrawer: () => {this._scaffoldKey.currentState.openDrawer()},
            )),
        drawer: AppDrawer(),
        body: _renderContent(context),
        floatingActionButton: AddButton(),
      ),
    );
  }
}

class TaskListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = '';
    Map<String, dynamic> filter =
        context.select<FilterProvider, Map<String, dynamic>>(
            (f) => {'filter': f.filter, 'filterValue': f.filterValue});
    if (filter['filter'] == TaskFilter.date) {
      title = 'TODAY\'S TASK';
    } else if (filter['filter'] == TaskFilter.category) {
      title = 'CATEGORY: ${filter['filterValue'].name}';
    } else if (filter['filter'] == TaskFilter.completed) {
      title = 'COMPLETED TASK\'S';
    } else if (filter['filter'] == TaskFilter.pending) {
      title = 'PENDING TASK\'S';
    }
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> with TickerProviderStateMixin {
  AnimationController _animationController;

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

  void _onTapAddButton(context) async {
    _animationController.forward().then((value) {
      Navigator.pushNamed(context, '/add-task').then((dynamic data) {
        _animationController.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.25).animate(_animationController),
        child: Icon(CupertinoIcons.plus),
      ),
      onPressed: () => _onTapAddButton(context),
    );
  }
}

class AppBarWithSearch extends StatefulWidget {
  final Function onOpenDrawer;
  AppBarWithSearch({@required this.onOpenDrawer})
      : assert(onOpenDrawer != null);
  @override
  _AppBarWithSearchState createState() => _AppBarWithSearchState();
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  bool _showSearch = false;
  void _onSearch(String value) {
    context.read<FilterProvider>().search(value);
  }

  void _onSwitchSearch() {
    if (_showSearch) {
      context.read<FilterProvider>().search('');
    }
    setState(() {
      _showSearch = !_showSearch;
    });
  }

  void _onTapNotifications() async {
    Navigator.pushNamed(context, '/add-notes');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.bars,
          size: 28,
        ),
        splashRadius: 25,
        onPressed: this.widget.onOpenDrawer,
      ),
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        transitionBuilder: (Widget widget, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: widget,
          );
        },
        child: _showSearch
            ? TextField(
                key: Key('show-search-field-1'),
                onChanged: _onSearch,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search here...",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ))
            : SizedBox(
                key: Key('show-search-field-2'),
              ),
      ),
      actions: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget widget, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          },
          child: _showSearch
              ? IconButton(
                  key: Key('show-search-1'),
                  onPressed: _onSwitchSearch,
                  splashRadius: 25,
                  icon: Icon(
                    CupertinoIcons.multiply,
                    size: 25,
                  ))
              : IconButton(
                  key: Key('show-search-2'),
                  onPressed: _onSwitchSearch,
                  splashRadius: 25,
                  icon: Icon(
                    CupertinoIcons.search,
                    size: 25,
                  )),
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
          onPressed: _onTapNotifications,
        ),
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  onTapTask(BuildContext context, MTask task, bool completed) {
    context.read<CoreProvider>().updateTableTask(MTask(
        id: task.id,
        categoryId: task.categoryId,
        categoryName: task.categoryName,
        name: task.name,
        date: task.date,
        time: task.time,
        completed: completed,
        color: task.color));
  }

  @override
  Widget build(BuildContext context) {
    List<MTask> tasks = context.watch<TaskProvider>().tasks;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: tasks.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext _, int index) {
          return TaskCard(
            key: Key('task-card-$index'),
            completed: tasks[index].completed,
            id: tasks[index].id,
            name: tasks[index].name,
            color: HexColor.fromHex(tasks[index].color),
            onTap: (bool completed) {
              onTapTask(context, tasks[index], completed);
            },
          );
        },
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MCategory> categories = context.watch<CategoryProvider>().categories;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (BuildContext _context, int index) {
        return CategoryCard(
          key: Key('cat-card-$index'),
          category: categories[index].name,
          totalTaskCount: categories[index].totalTasks,
          completedTasks: categories[index].completedTasks,
          progressColor: HexColor.fromHex(categories[index].color),
          onTap: () {
            context
                .read<FilterProvider>()
                .changeFilter(TaskFilter.category, value: categories[index]);
          },
        );
      },
    );
  }
}
