import 'package:flutter/material.dart';

/// Flutter code sample for [MenuAnchor].

enum SampleItem { itemOne, itemTwo, itemThree }

class MenuAnchorApp extends StatelessWidget {
  const MenuAnchorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MenuAnchorExample(),
    );
  }
}

class MenuAnchorExample extends StatefulWidget {
  const MenuAnchorExample({super.key});

  @override
  State<MenuAnchorExample> createState() => _MenuAnchorExampleState();
}

class _MenuAnchorExampleState extends State<MenuAnchorExample> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MenuAnchor(
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return IconButton(
                  color: Colors.black,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_horiz),
                  tooltip: 'Show menu',
                );
              },
              menuChildren: List<MenuItemButton>.generate(
                3,
                (int index) => MenuItemButton(
                  onPressed: () =>
                      setState(() => selectedMenu = SampleItem.values[index]),
                  child: Text('Item ${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
