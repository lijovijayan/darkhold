import 'package:darkhold/provider/task.provider.dart';
import 'package:darkhold/utils/common.utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
import '../models/models.dart';
import '../utils/select-utils.dart';
import '../provider/category.provider.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._dateController.dispose();
    this._timeController.dispose();
    super.dispose();
  }

  void _onAddTask() {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      MCategory _category = MCategory(
          id: TaskFormData.category.id,
          name: TaskFormData.category.name,
          totalTasks: TaskFormData.category.totalTasks + 1,
          completedTasks: TaskFormData.category.completedTasks,
          color: TaskFormData.category.color);
      context.read<PTask>().addTask(
          category: _category,
          name: TaskFormData.name,
          date: TaskFormData.date,
          time: TaskFormData.time);
      context.read<PCategory>().updateCategory(_category);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      _dateController.value =
          TextEditingValue(text: getFormatedDateString(picked));
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      _timeController.value =
          TextEditingValue(text: getFormatedTimeString(picked));
      setState(() {
        _selectedTime = picked;
      });
    }
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
          child: Form(
            key: _formKey,
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
                CategorySelect(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Title',
                  style: Theme.of(context).primaryTextTheme.headline6,
                ),
                TextFormField(
                  onSaved: (String name) {
                    TaskFormData.name = name;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'name is required'),
                    MinLengthValidator(4,
                        errorText: 'name must be atleast 4 characters long'),
                  ]),
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
                  validator: RequiredValidator(errorText: 'date is required'),
                  onTap: () {
                    _selectDate();
                  },
                  onSaved: (String date) {
                    TaskFormData.date = date;
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
                  validator: RequiredValidator(errorText: 'time is required'),
                  onTap: () {
                    _selectTime();
                  },
                  onSaved: (String time) {
                    TaskFormData.time = time;
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

class CategorySelect extends StatefulWidget {
  @override
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect>
    with TickerProviderStateMixin {
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

  void _switchCategoryAdd(PCategory category) async {
    _animationController.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => AddCategoryPopup(),
    ).then((value) async {
      String _category = value['category'];
      bool _isActive = value['active'];
      final MCategory _newCategory = await category.addCategory(_category);
      _animationController.reverse().then((value) {
        if (_isActive) {
          TaskFormData.category = _newCategory;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext _context) {
    return Consumer(
        builder: (BuildContext context, PCategory category, Widget child) {
      return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
          child: DropdownSearch<MCategory>(
            selectedItem: TaskFormData.category,
            onSaved: (_category) {
              TaskFormData.category = _category;
            },
            validator: (v) => v == null ? "category is required" : null,
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
            items: category.categories,
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
              turns:
                  Tween(begin: 0.0, end: 0.125).animate(_animationController),
              child: Icon(Icons.add),
            ),
            onPressed: () {
              _switchCategoryAdd(category);
            },
          ),
        ),
      ]);
    });
  }
}

class TaskFormData {
  static MCategory category;
  static String name;
  static String color;
  static String date;
  static String time;
}
