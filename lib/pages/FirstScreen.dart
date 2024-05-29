import 'package:flutter/material.dart';
import '../component/DrawerCheck.dart';
import 'barcheck.dart';
import 'todo.dart';
import 'option.dart';
class Firstscreen extends StatefulWidget {
  const Firstscreen({Key? key}) : super(key: key);

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  final List<Todo> todos = <Todo>[];

  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();

  //Handle Change function for todo list
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  //Remove To Do function to delete a to do
  void _deleteTodo(Todo todo) {
    setState(() {
      todos.removeWhere((element) => element.title == todo.title);
    });
  }

  //add to do item function
  void _addTodoItem(String title, String name, String text, String color) {
    setState(() {
      todos.add(Todo(
          title: title,
          name: name,
          completed: false,
          text: text,
          color: color));
    });

    _textFieldController.clear();
    _textFieldController2.clear();
    _textFieldController3.clear();
  }


  //dialog box for more-horizontal in list


//dialog box func along with the text field and add & cancel buttons
  Future<void> display() async {
    String selectedText = 'Medium';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 360.0,
          height: 400.0,
          child: AlertDialog(
            // backgroundColor: Colors.yellow,
            title: const Text('Create a new task'),
            content: Container(
              padding: const EdgeInsets.all(0),
              width: 600.0,
              height: 400.0,
              // color: Colors.red,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: TextField(
                      controller: _textFieldController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Title'), //act as a placeholder
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: TextField(
                      controller: _textFieldController2,
                      decoration: const InputDecoration(
                          hintText: 'Enter Description'), //act as a placeholder
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Priorities',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    width: 300,
                    // margin: EdgeInsets.zero,
                    // color: Colors.blue,
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedText = 'High';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent[100],
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const SizedBox(
                            width: 20,
                            child: Text(
                              'High',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedText = 'Medium';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[100],
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const Text(
                            'Medium',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedText = 'Low';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[100],
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const SizedBox(
                            width: 22,
                            child: Text(
                              'Low',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(
                    _textFieldController.text,
                    _textFieldController2.text,
                    _textFieldController3.text,
                    selectedText,
                  );
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 0, 20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.purple,
                      gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                          begin: Alignment.centerRight,
                          end: Alignment(-1.0, -1.0)),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                              child: Text(
                                'Personal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.purple,
                      gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                          begin: Alignment.centerRight,
                          end: Alignment(-1.0, -1.0)),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 0, 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  children: todos.map((Todo todo) {
                    return TodoItem(
                        todo: todo,
                        onTodoChanged: handleTodoChange,
                        removeTodo: _deleteTodo);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: drawer(
        title: 'New',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => display(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const bar(),
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChanged,
      required this.removeTodo})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  // Future<void> showOptionsDialog(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: const SizedBox(
  //           width: 200,
  //           height: 100, // Adjusted height for two rows
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Text(
  //                     'Update',
  //                     style: TextStyle(color: Colors.black, fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 20),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'Delete',
  //                     style: TextStyle(color: Colors.black, fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           OutlinedButton(
  //             style: OutlinedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  todo.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      todo.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pop();
                  },
                  child: Text(
                    todo.color,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () => {
                  showOptionsDialog(context)
                  },
                  // onPressed: () => removeTodo(todo),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
