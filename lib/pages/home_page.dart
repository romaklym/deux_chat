import 'package:deux_chat/pages/accept_invite.dart';
import 'package:deux_chat/pages/home_tab.dart';
import 'package:deux_chat/pages/sent_invite.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const AcceptInvite(),
    const SentInvite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check,
              color: Colors.deepPurple,
            ),
            label: 'Accept Invitation',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.send,
              color: Colors.deepPurple,
            ),
            label: 'Send Invitation',
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
