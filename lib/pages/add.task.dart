import 'package:darkhold/provider/core.provider.dart';
import 'package:darkhold/provider/proxy.category.provider.dart';
import 'package:darkhold/utils/common.utils.dart';
import 'package:darkhold/widgets/bottom.sheet.select.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'pages.dart';

class AddTaskPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  void _onAddTask(BuildContext context) {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      MCategory _category = MCategory(
          id: TaskFormData.category.id,
          name: TaskFormData.category.name,
          totalTasks: TaskFormData.category.totalTasks + 1,
          completedTasks: TaskFormData.category.completedTasks,
          color: TaskFormData.category.color);
      context.read<CoreProvider>().addTask(
          category: _category,
          name: TaskFormData.name,
          date: TaskFormData.date,
          time: TaskFormData.time);
      Navigator.of(context).pop();
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
                DateSelect(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time',
                  style: Theme.of(context).primaryTextTheme.headline6,
                ),
                TimeSelect(),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
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
        bottomSheet: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
            ? SizedBox()
            : InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        width: 1, color: Theme.of(context).hintColor),
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
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w300),
                      ),
                      Icon(
                        Icons.add,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  _onAddTask(context);
                },
              ),
      ),
    );
  }
}

class DateSelect extends StatefulWidget {
  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

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

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class TimeSelect extends StatefulWidget {
  @override
  TimeSelectState createState() => TimeSelectState();
}

class TimeSelectState extends State<TimeSelect> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  TextEditingController _timeController = TextEditingController();

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
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class CategorySelect extends StatefulWidget {
  @override
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  MCategory _selectedCategory;
  TextEditingController _categoryController = TextEditingController();
  bool _preventBottonSheet = false;
  void _onAddCategory() async {
    _preventBottonSheet = true;
    showDialog(
      context: context,
      builder: (BuildContext context) => AddCategoryPopup(),
    ).then((value) async {
      _preventBottonSheet = false;
      if (value != null) {
        String _category = value['category'];
        bool _isActive = value['active'];
        final MCategory _newCategory =
            await context.read<CoreProvider>().addCategory(_category);
        if (_isActive) {
          TaskFormData.category = _newCategory;
          setState(() {});
        }
      }
    });
  }

  Future<void> _onTap() async {
    if (_preventBottonSheet) return;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (BuildContext _) {
        return BottomSheetSelect<MCategory>(
          title: 'Select Category',
          items: context.watch<CategoryProvider>().categories,
          selected: _selectedCategory,
          labelSelector: (MCategory cat) => cat.name,
          onTap: (MCategory category) {
            if (category != null) {
              _categoryController.value = TextEditingValue(text: category.name);
              setState(() {
                _selectedCategory = category;
              });
            }
          },
        );
      },
      context: context,
      enableDrag: false,
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _categoryController,
      readOnly: true,
      onTap: _onTap,
      onSaved: (String value) {
        TaskFormData.category = this._selectedCategory;
      },
      validator: MultiValidator([
        RequiredValidator(errorText: 'category is required'),
      ]),
      decoration: InputDecoration(
        hintText: 'Select Category',
        suffixIcon: IconButton(
          icon: Icon(Icons.add),
          onPressed: _onAddCategory,
        ),
      ),
    );
  }
}

class TaskFormData {
  static MCategory category;
  static String name;
  static String color;
  static String date;
  static String time;
}
