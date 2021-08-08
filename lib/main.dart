import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/widgets/add_task.dart';
import 'package:to_do/widgets/task_list.dart';
import 'package:to_do/widgets/todo_appbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController addTaskController = TextEditingController();

  final FocusNode addTaskFocusNode = FocusNode();

  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("ToDo Tasks");

  void addTask() async {
    if (addTaskController.text.isNotEmpty) {
      await tasks.add({
        "task": addTaskController.text,
        "isComplete": false,
        "createdAt": DateTime.now(),
      });
      print("**************Added\n");
      addTaskController.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            child: Column(
              children: [
                TodoAppbar(),
                SizedBox(height: 18),
                AddTask(
                  addTask: addTask,
                  addTaskController: addTaskController,
                ),
                TaskListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
