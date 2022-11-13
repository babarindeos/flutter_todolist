// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority = 'Select Priority Level';
  DateTime _date = DateTime.now();

  TextEditingController _dateController = new TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(_date);
    }
  }

  void dispose() {
    _dateController.dispose();
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_title, $_date, $_priority');

      // insert the task to our user's database

      // update the task

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Add Task',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14.0),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(fontSize: 14.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? "Please enter a task title"
                              : null,
                          initialValue: _title,
                          onSaved: (input) => _title = input!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: TextStyle(fontSize: 14.0),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(fontSize: 14.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                          validator: (input) => _priority == null
                              ? 'Please select a priority level'
                              : null,
                          onSaved: (input) => _priority = input!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            'Add',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
