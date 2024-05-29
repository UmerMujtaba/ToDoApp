import 'package:flutter/material.dart';
import 'FirstScreen.dart';

class bar extends StatefulWidget {
  const bar({Key? key}) : super(key: key);

  @override
  State<bar> createState() => _barState();
}

class _barState extends State<bar> {
  //fun to show calendar in a dialog box
  Future<void> calendar() async {
    DateTime firstDate = DateTime(2010, 10, 16);
    DateTime lastDate = DateTime(2030, 3, 14);
    DateTime selectedDate = DateTime.now();

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select a date',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Pick a date'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      "Selected date: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
                  // Splitting the selected date into year, month, and day
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTabIndex = 1;

  void _onTabTapped(int index) async {
    if (index == 0) {
Navigator.pushNamed(context, '/drawer');
    }
    if (index == 1) {

      Navigator.pushReplacementNamed(context, '/first');
    }
    if (index == 2) {
      await calendar();
    }
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 60,
      child:
      Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 8,
        iconSize: 24,
        selectedIconTheme:
            const IconThemeData(color: Colors.blueAccent, size: 28),
        selectedItemColor: Colors.blueAccent,
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        unselectedItemColor: Colors.deepOrangeAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '',
          ),
        ],
        currentIndex: _selectedTabIndex,
        //New
        onTap: _onTabTapped,
      ),
      ),
    );
  }
}