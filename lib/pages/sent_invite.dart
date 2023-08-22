import 'package:deux_chat/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SentInvite extends StatefulWidget {
  const SentInvite({super.key});

  @override
  State<SentInvite> createState() => _SentInviteState();
}

class _SentInviteState extends State<SentInvite> {
  final uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Sent Invite'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyTextField(
                  controller: uidController,
                  hintText: "Send invite to UID",
                  obscureText: false),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple), // Set the background color
                ),
                child: Text(
                  'Send Invite',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
