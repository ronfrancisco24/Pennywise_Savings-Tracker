import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';
import '../authentication/auth_service.dart';
import '../data/firebase_data.dart';
import 'invitationgenerator.dart'; // Import your InvitationPage

class BoardEntry{
  final String name;
  final double amount;

  BoardEntry({
    required this.name,
    required this.amount,
  });
}


class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  late String inviteCode;
  List<BoardEntry> entries = [];
  List<BoardEntry> userEntry = [];

  final AuthService authService = AuthService();
  final FirebaseData fireStore = FirebaseData();

  @override
  void initState() {
    super.initState();
    // Generate the invite code for this leaderboard
    inviteCode = generateInviteCode("your_leaderboard_id");
    _fetchEntries();
  }

  // Function to generate the invite code
  String generateInviteCode(String leaderboardId) {
    return '$leaderboardId-${DateTime
        .now()
        .millisecondsSinceEpoch}';
  }

  void _fetchEntries() {
    final username = authService.getUserName();
    userEntry = [
      BoardEntry(name: "$username", amount: 1238.34),
      //TODO: call the amount from tracker.dart
    ];
    entries = [
      // BoardEntry(name: "", amount: ), for entry purposes
      BoardEntry(name: "Jaja", amount: 1234.78),
      BoardEntry(name: "Joseph", amount: 20070.60),
      // BoardEntry(name: "Sean", amount: 10560.34),
      // BoardEntry(name: "Joaquin", amount: 8900.91),
      // BoardEntry(name: "Helaina", amount: 9340.34),
    ];

    entries.addAll(userEntry);

    entries.sort((a, b) => b.amount.compareTo(a.amount));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final username = authService.getUserName();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 900,
                decoration: const BoxDecoration(
                  gradient: kLinearGradient,
                ),
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20, top: 40),
                        child: const Text(
                          "Leaderboard",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (entries.length >= 3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 3; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: topThree(
                                      entries[i].name,
                                      Icons.person,
                                      '₱',
                                      entries[i].amount,
                                    ),
                                  ),
                              ],
                            ),
                          const SizedBox(height: 40),
                          userContainer('$username', Icons.person, '₱', 12388),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Your Friends",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  inviteCode = generateInviteCode("My ID Code");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InvitationPage(inviteCode: inviteCode),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Invite Friends',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Add a fixed height container for the friends list
                    Container(
                      height: 300, // Set a fixed height for the list view
                      child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                            child: friendContainer(
                              entry.name,               // Name of the friend
                              Icons.person,             // Icon to display
                              '₱',                      // Currency symbol
                              entry.amount,            // Amount to display
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: kBottomAppBar(context),
      ),
    );
  }


  Widget topThree(String name, IconData icon, String currency, double friendSavings) {
    return Container(
      height: 150,
      width: 107,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 3,
              offset: const Offset(0, 5),
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Text(
          //
          // ),
          Icon(
            icon,
            color: Colors.black,
            size: 40,
          ),
          const Spacer(),
          Text(
            name,
            style: kMontserratBlackSmall,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              Text(
                friendSavings.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],

      ),
    );
  }

   Widget friendContainer(String name, IconData icon, String currency, double friendSavings) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 70,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  currency,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                Text(
                  friendSavings.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 25),
                // Text(
                //   rank.toString(),
                //   style: const TextStyle(
                //     fontSize: 10,
                //     color: Colors.black,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userContainer(String name, IconData icon, String currency, double friendSavings) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 70,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color(0xffb1d4e0),
            Color(0xFFbbd8ff),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  currency,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                Text(
                  friendSavings.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 25),
                // Text(
                //   rank.toString(),
                //   style: const TextStyle(
                //     fontSize: 10,
                //     color: Colors.black,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
