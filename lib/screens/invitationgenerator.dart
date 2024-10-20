import 'package:flutter/material.dart';
import 'package:savings_2/screens/profile.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../widgets/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class InvitationPage extends StatefulWidget {
  final String inviteCode;
  InvitationPage({required this.inviteCode});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  late String inviteCode;

  @override
  void initState() {
    super.initState();
    inviteCode = widget.inviteCode;
    // Generates the invite code
  }

  // function that generates the invite code
  String generateInviteCode() {
    return 'your_leaderboard_id-${DateTime.now().millisecondsSinceEpoch}';
  }

  void copyToClipboard(BuildContext context) {
    if (inviteCode.isNotEmpty) {
      // Check if inviteCode is not empty
      Clipboard.setData(ClipboardData(text: inviteCode));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invite Code copied to clipboard!')),
      );
    } else {
      print('No invite code available to copy.'); // Log if inviteCode is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Your Invite Code'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: kGradientColors,
                    height: 250,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          inviteCode,
                          style: kNormalSansWhiteSmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.content_copy_rounded,
                                  color: Colors.white),
                              onPressed: () => copyToClipboard(context),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blueAccent[100],
                                backgroundColor: Colors.white
                              ),
                              onPressed: () {
                                Share.share(
                                    'Input my Code: $inviteCode'); //Generated Invite Code
                              },
                              child: Text('Share Invite Code'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
