// ignore_for_file: prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/add_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  final String title;
  const TodoListScreen({super.key, required this.title});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Widget _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Task Title'),
            subtitle: Text('Oct 2,2019 : High'),
            trailing: Checkbox(
              onChanged: (value) {
                debugPrint(value.toString());
                value = value;
              },
              activeColor: Theme.of(context).primaryColor,
              value: true,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddTaskScreen())),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 80.0),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Tasks',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '1 of 10',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }

            /* return Container(
              color: Colors.red,
              height: 100.0,
              width: double.infinity,
              margin: EdgeInsets.all(10.0),
              child: Text(index.toString()),
            ); */

            return _buildTask(index);
          }),
    );
  }
}
