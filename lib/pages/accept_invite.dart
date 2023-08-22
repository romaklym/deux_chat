import 'package:flutter/material.dart';

class AcceptInvite extends StatefulWidget {
  const AcceptInvite({super.key});

  @override
  State<AcceptInvite> createState() => _AcceptInviteState();
}

class _AcceptInviteState extends State<AcceptInvite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Accept Invite'),
      ),
    );
  }
}
