import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskie/models/task.dart';

class Homepage extends StatefulWidget
// A StatefulWidget class is used when the part of the user interface
// needs to change dynamically in response to user interaction or
// other events over time
{
  Box? _box;
  Homepage();
  // Default constructor

  @override
  State<StatefulWidget> createState() {
    // This method should return a State object for this widget.
    // createState() returns a new private state class _HomePageState
    return _HomePageState();
  }
}

class _HomePageState extends State<Homepage> {
  late double _deviceHeight, _devicewidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();
  @override
  Widget build(BuildContext context) {
    // build method is automatically called whenever the widget is build
    // or rebuilt.
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Scaffold is a basic structure that provides a skeleton layout
      // for Flutter apps.
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: Text(
          'VinTask',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _taskList();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _taskList() {
    // Task _newTask = Task(content: "Go to Gym!", timestamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List _tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(_tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(decoration:task.done ? TextDecoration.lineThrough :null),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done ? Icons.check_box_outlined:Icons.check_box_outline_blank_outlined,
            color: Colors.red,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(_index, task.toMap());
            setState(() {
              _tasks = _box!.values.toList();
            });
          },
          onLongPress:() {
            _box!.deleteAt(_index);
            setState((){});
          }, 
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: Icon(
        Icons.add,
      ),
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              onSubmitted: (_) {
                if (_newTaskContent != null){
                  var _task = Task(content: _newTaskContent! ,timestamp:DateTime.now(),done: false );
                  _box!.add(_task.toMap());
                  setState(() {
                    _newTaskContent=null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}
