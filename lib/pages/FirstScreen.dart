import 'package:flutter/material.dart';
import 'todo.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/first');
    }
    if (index == 1) {
      _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
    }
    if (index == 2) {
      Navigator.pushReplacementNamed(context, '/second');
    }
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedTabIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
        ],
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                      begin: Alignment.centerRight,
                      end: Alignment(-1.0, -1.0)),
                ),
                child: null,
              ),
              const SizedBox(height: 20),
              ListTile(
                //leading: Icon(Icons.category),
                title: const Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  // Add your onTap logic here
                },
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(Icons.person,
                            size: 30, color: Colors.blueAccent[100]),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Personal',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.list_alt,
                            size: 30, color: Colors.blueAccent[100]),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Wishlist',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.cake,
                            size: 30, color: Colors.blueAccent[100]),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Birthday',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Divider(height: 2),
              ListTile(
                leading: Icon(Icons.reorder,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Reorder Tasks'),
                onTap: () {
                  // Add your onTap logic for item 1 here
                },
              ),
              ListTile(
                leading: Icon(Icons.workspace_premium,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Premium'),
                onTap: () {
                  // Add your onTap logic for item 2 here
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.star, size: 30, color: Colors.blueAccent[100]),
                title: const Text('Rate us'),
                onTap: () {
                  // Add your onTap logic for item 2 here
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Setting'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/setting');
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
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
                            colors: [
                              Colors.deepPurpleAccent,
                              Colors.cyanAccent
                            ],
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
                            colors: [
                              Colors.deepPurpleAccent,
                              Colors.cyanAccent
                            ],
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => display(),
            tooltip: 'Add a Todo',
            child: const Icon(Icons.add),
          ),
        ),
      ),
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
                  icon: const Icon(Icons.delete),
                  onPressed: () => removeTodo(todo),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
