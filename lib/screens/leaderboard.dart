import 'package:flutter/material.dart';
import 'package:savings_2/screens/tracker.dart';
import 'package:savings_2/widgets/constants.dart';
import 'home_page.dart';

void main() {
  runApp (LeaderBoardPage());
}
class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff264193),
                    Color(0xFF81BED4),
                  ],
                ),
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
                  )
                            ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      topThree("Joseph Josephine", Icons.person, '₱', 20000),
                      SizedBox(width: 10),
                      topThree("Sean Beaugawke", Icons.person, '₱', 13000),
                      SizedBox(width: 10),
                      topThree("Joaking Dinnerbone", Icons.person, '₱', 10000),
                      SizedBox(width: 10),
                      SizedBox(height: 20),
                    ]
                  ),
                  SizedBox(height: 40),
                  userContainer("Aaron FranCisco NetAcad", Icons.person, '₱', 12388, 5),
                  SizedBox(height:40),
                  Padding(
                    padding: EdgeInsets.only(right: 200.0),
                    child: Text(
                      "Your Friends",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  containerContent("Francis D'Bouleboel", Icons.person, '₱', 12323, 6),
                  SizedBox(height: 20),
                  containerContent('Matthew Shi Thead', Icons.person, '₱', 234, 7),
                  SizedBox(height: 20),
                  containerContent('Helaina Mallaria', Icons.person, '₱', 345,8),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: kBottomAppBar(context)
      ),
    );
  }
}
Widget topThree(String name, IconData icon, String currency, int friendSavings){
  return Container(
    height: 150,
    width: 107,
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 3,
            offset: Offset(0, 5),
          )
        ]
    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Icon(
          icon,
          color: Colors.black,
          size: 40,
        ),
        Spacer(),
        Text(
          name,
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Row(
          children: [
            Text(
              currency,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            Text(
              friendSavings.toString(),
              style: TextStyle(
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

Widget containerContent(String name, IconData icon, String currency, int friendSavings, int rank) {
  return Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        constraints: BoxConstraints(
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
                offset: Offset(0, 5),
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
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
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
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              Text(
                friendSavings.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            SizedBox(width: 25),
            Text(
              rank.toString(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget userContainer(String name, IconData icon, String currency, int friendSavings, int rank) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    constraints: BoxConstraints(
      maxWidth: 350,
      maxHeight: 70,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
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
          offset: Offset(0, 5),
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
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
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
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              Text(
                friendSavings.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 25),
              Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

