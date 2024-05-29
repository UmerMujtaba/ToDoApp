import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
    return SafeArea(
      child: Scaffold(
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
                    end: Alignment(-1.0, -1.0),
                  ),
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
                    color: Colors.black,
                  ),
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
                  Navigator.pushNamed(context, '/setting');
                },
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 30, 0, 10),
          height: 250,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.black,

                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.share,color: Colors.blueAccent[100],size: 24,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('Share',
                          style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.thumb_up_sharp,size: 24,color: Colors.blueAccent[100],),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
