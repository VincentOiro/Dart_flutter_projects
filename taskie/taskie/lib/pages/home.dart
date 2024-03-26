import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget
// A StatefulWidget class is used when the part of the user interface
// needs to change dynamically in response to user interaction or
// other events over time
{
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
        if (_snapshot.connectionState==ConnectionState.done) {
          _box=_snapshot.data;
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
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Do Laundry',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(
            Icons.check_box_outlined,
            color: Colors.red,
          ),
        ),
        ListTile(
          title: Text(
            'Do Laundry',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(
            Icons.check_box_outlined,
            color: Colors.red,
          ),
        )
      ],
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
              onSubmitted: (_value) {},
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
