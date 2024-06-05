import 'package:flutter/material.dart';
import '../screens/FirstScreen.dart';
import '../screens/FrontScreen.dart';
import '../screens/PremiumScreen.dart';
import '../screens/SettingsScreen.dart';
import 'DrawerCheck.dart';
import '../model/todoprovider.dart';

class bar extends StatefulWidget {

  const bar({Key? key}) : super(key: key);

  @override
  State<bar> createState() => _barState();

}

class _barState extends State<bar> {
  TodoProvider todoProvider = TodoProvider();
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

  int _selectedTabIndex = 1;

  void _onTabTapped(int index) async {
    if (index == 0) {
      Navigator.pushNamed(context, '/drawer');
    }
    if (index == 1) {
      Navigator.restorablePushReplacementNamed(context, '/first');
    }
    if (index == 2) {
      await calendar();
    }
    setState(() {
      _selectedTabIndex = index;
    });
  }

  int currentTab = 0;
  final List<Widget> screens = [
    Firstscreen(todoProvider: TodoProvider()),
    const Frontscreen(),
    const Premium(),
    const Setting(),
    const drawer(title: 'ok'),
  ];

  Widget currentscreen = Firstscreen(todoProvider: TodoProvider()); // Pass _todoProvider to FirstScreen

  // final storageBucket bucket = storageBucket();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Scaffold(
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
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}

// storage(
// child: currentscreen,
// bucket: bucket,
// ),
// floatingActionButton: FloatingActionButton(
// child: Icon(Icons.add),
// onPressed: () {},
// ),
// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// bottomNavigationBar: BottomAppBar(
// shape: CircularNotchedRectangle(),
// notchMargin: 10,
// child: Container(
// height: 60,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// MaterialButton(
// minWidth: 40,
// onPressed: () {
// setState(() {
// currentscreen=Firstscreen();
// currentTab=0;
// });
// },
// child: Column (
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(Icons.dashboard,
// color: currentTab == 0 ? Colors.blue : Colors.grey,),
// Text(
// 'Dashboard',
// style: TextStyle(
// color: currentTab==0?Colors.blue:Colors.grey
// ),
// )
//
// ],
// ),
// )
// ],
// )
// )
// ),grey
