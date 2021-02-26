import '../models/models.dart';
import '../utils/select-utils.dart';
import '../widgets/widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  AnimationController _animationController;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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
    this._dateController.dispose();
    this._timeController.dispose();
    super.dispose();
  }

  void _onAddTask() {
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      final day = _getFormatedValue(picked.day);
      final month = _getFormatedValue(picked.month);
      _dateController.value =
          TextEditingValue(text: '$day-$month-${picked.year}');
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      final period = picked.period == DayPeriod.pm ? 'PM' : 'AM';
      final _hour =
          picked.period == DayPeriod.pm ? picked.hour - 12 : picked.hour;
      final hour = _getFormatedValue(_hour);
      final minute = _getFormatedValue(picked.minute);
      _timeController.value = TextEditingValue(text: '$hour:$minute: $period');
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _onAddCategory(Map<String, dynamic> value) {
    // final Map<String, dynamic> data = {
    //   'category': _inputController.value,
    //   'active': _checked,
    // };
  }

  void _switchCategoryAdd() {
    _animationController.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => AddCategoryPopup(),
    ).then((value) => {
          _animationController.reverse(),
          _onAddCategory(value),
        });
  }

  String _getFormatedValue(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  @override
  Widget build(BuildContext context) {
    Widget _renderContent() {
      return Container(
        height: (MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom +
                MediaQuery.of(context).padding.top)),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Add New',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Task',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Category',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                  child: DropdownSearch<MCategory>(
                    validator: (v) => v == null ? "required field" : null,
                    mode: Mode.MENU,
                    compareFn: (MCategory i, MCategory s) {
                      if (i != null && s != null) {
                        return i.id == s.id;
                      }
                      return false;
                    },
                    onChanged: (MCategory data) {
                      print(data.name);
                    },
                    popupItemBuilder: selectboxItemBuilder,
                    dropdownBuilder: dropdownBuilder,
                    showSelectedItem: true,
                    items: [
                      MCategory(
                        id: 0,
                        name: 'Catagorey 1',
                        color: 'red',
                        completedTasks: 0,
                        totalTasks: 0,
                      ),
                      MCategory(
                        id: 1,
                        name: 'Catagorey 2',
                        color: 'red',
                        completedTasks: 0,
                        totalTasks: 0,
                      ),
                      MCategory(
                        id: 2,
                        name: 'Catagorey 3',
                        color: 'red',
                        completedTasks: 0,
                        totalTasks: 0,
                      ),
                      MCategory(
                        id: 3,
                        name: 'Catagorey 4',
                        color: 'red',
                        completedTasks: 0,
                        totalTasks: 0,
                      ),
                      MCategory(
                        id: 4,
                        name: 'Catagorey 5',
                        color: 'red',
                        completedTasks: 0,
                        totalTasks: 0,
                      ),
                    ],
                    showClearButton: true,
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder
                            .borderSide),
                  ),
                  child: IconButton(
                    splashRadius: 25,
                    icon: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.125)
                          .animate(_animationController),
                      child: Icon(Icons.add),
                    ),
                    onPressed: _switchCategoryAdd,
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Text(
                'Title',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Here...',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Date',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              TextFormField(
                controller: _dateController,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                  hintText: 'DD:MM:YYYY',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Time',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              TextFormField(
                controller: _timeController,
                onTap: () {
                  _selectTime(context);
                },
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.alarm),
                  hintText: 'HH:MM:XX',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          splashRadius: 25,
        ),
      ),
      body: _renderContent(),
      bottomSheet: InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1, color: Theme.of(context).hintColor),
          )),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 36,
              ),
              Text(
                'Add Task',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w300),
              ),
              Icon(
                Icons.add,
                size: 32,
              ),
            ],
          ),
        ),
        onTap: _onAddTask,
      ),
    );
  }
}
