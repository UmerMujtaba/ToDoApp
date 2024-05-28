import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Secondscreen extends StatefulWidget {
  const Secondscreen({Key? key}) : super(key: key);

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.purple],
                      begin: Alignment.centerRight,
                      end: Alignment(-1.0, -1.0)),
                ),
                child: null),
            SizedBox(height: 20),
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
                  SizedBox(height: 30),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.cake, size: 30, color: Colors.blueAccent[100]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Birthday',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Divider(height: 2),
            ListTile(
              leading:
                  Icon(Icons.reorder, size: 30, color: Colors.blueAccent[100]),
              title: Text('Reorder Tasks'),
              onTap: () {
                // Add your onTap logic for item 1 here
              },
            ),
            ListTile(
              leading: Icon(Icons.workspace_premium,
                  size: 30, color: Colors.blueAccent[100]),
              title: Text('Premium'),
              onTap: () {
                // Add your onTap logic for item 2 here
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.star, size: 30, color: Colors.blueAccent[100]),
              title: Text('Rate us'),
              onTap: () {
                // Add your onTap logic for item 2 here
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.settings, size: 30, color: Colors.blueAccent[100]),
              title: Text('Setting'),
              onTap: () {
                // Navigator.pushNamed(context, '/');
                // // Simulate a delay for loading
                // Future.delayed(
                //   Duration(seconds: 5),
                //   ()
                //   {
                    Navigator.pushReplacementNamed(context, '/first');
                  // },
               // );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(
                      () {
                        _selectedDay = selectedDay;
                        _focusedDay =
                            focusedDay; // update `_focusedDay` here as well
                      },
                    );
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ],
          ),
          //bottomNavigationBar: Bar(),  // Use the custom bottom navigation bar
        ),
      ),
    );
  }
}
