import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';

class Dashboard extends StatefulWidget {
  final Widget body;
  const Dashboard({super.key, required this.body});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go(RoutePath.home);
        break;
      case 1:
        context.go(RoutePath.myCourse);
        break;
      case 2:
        context.go(RoutePath.inbox);
        break;
      case 3:
        context.go(RoutePath.profile);
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'My Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        elevation: 0,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: changeTab,
      ),
    );
  }
}
