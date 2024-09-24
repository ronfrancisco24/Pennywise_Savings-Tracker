import 'package:flutter/material.dart';
import 'package:savings_2/personal_information.dart';
import 'main.dart';
import 'widgets/constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: kBottomAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: 380.0,
                height: 10,
                color: Colors.white,
              ),
              Container(
                width: 380,
                height: 130,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE5G0Nf9yWN8kRWNl8BMlisG-ZGSoWqrHPOA&s'),
                        radius: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Aaron Francisco',
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              'aaronfrancisco003@gmail.com',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: kLinearGradient,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(
                children: [
                  Container(
                    height: 35,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 200.0, top: 10),
                        child: Text(
                          'Account Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 380,
                height: 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInfoPage(),
                          ),
                        );
                        // Need pa ng pages
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 21,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Profile Information',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Colors.white,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Need pa ng pages
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.mobile_friendly,
                            color: Colors.white,
                            size: 21,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Connect with Friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Colors.white,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Need pa ng pages
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.ios_share_outlined,
                            color: Colors.white,
                            size: 21,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Colors.white,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: kLinearGradient,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Container(
                    height: 35,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 285.0, top: 8),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 380,
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Need pa ng pages
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(1), // Reduce padding
                        minimumSize: Size(150, 40), // Set the minimum size
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Text(
                            'Hide Me From Leaderboard',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          Spacer(),
                          ToggleSwitch(),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Need pa ng pages
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(1), // Reduce padding
                        minimumSize: Size(150, 40), // Set the minimum size
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Text(
                            'Hide Balance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          Spacer(),
                          ToggleSwitch()
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Need pa ng pages
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(1), // Reduce padding
                        minimumSize: Size(150, 40), // Set the minimum size
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Text(
                            'Notification',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          ToggleSwitch()
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Need pa ng pages
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(1), // Reduce padding
                        minimumSize: Size(150, 40), // Set the minimum size
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Text(
                            'Sound Effect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          ToggleSwitch()
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: kLinearGradient,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 8, bottom: 10), // Adjust this value to lower the container
                  child: TextButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      width: 380,
                      height: 50,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: kLinearGradient,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9, // Adjust the scale factor to make it smaller or larger
      child: Switch(
        value: isSwitched,
        onChanged: _toggleSwitch,
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
    );
  }
}

