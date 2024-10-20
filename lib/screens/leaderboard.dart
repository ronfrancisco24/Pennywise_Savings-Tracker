import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';
import 'invitationgenerator.dart'; // Import your InvitationPage

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  late String inviteCode;

  @override
  void initState() {
    super.initState();
    // Generate the invite code for this leaderboard
    inviteCode = generateInviteCode("your_leaderboard_id");
  }

  // Function to generate the invite code
  String generateInviteCode(String leaderboardId) {
    return '$leaderboardId-${DateTime.now().millisecondsSinceEpoch}';
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: kLinearGradient,
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Your Friends",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Generate the invite code for this leaderboard
                            inviteCode = generateInviteCode("My ID Code");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvitationPage(inviteCode: inviteCode),
                              ),
                            );
                          },
                          child: Text('Invite Friends', style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: kBottomAppBar(context),
      ),
    );
  }
}

