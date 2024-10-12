import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:savings_2/screens/leaderboard.dart';
import 'package:savings_2/screens/profile.dart';
import 'package:savings_2/screens/tracker.dart';

// big container with gradient background

final kGradientColors = BoxDecoration(
    gradient: kLinearGradient, borderRadius: BorderRadius.circular(30));

const kBlueColor = Color(0xff264193);
const kGreyColor = Color(0xffebedf0);

//Colors
const kLinearGradient = LinearGradient(
  colors: [Color(0xff264193), Color(0xff81bed4)], // Define gradient colors
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

//Circle Avatar
const kCircleAvatar = CircleAvatar(
  backgroundImage: NetworkImage(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE5G0Nf9yWN8kRWNl8BMlisG-ZGSoWqrHPOA&s'),
  radius: 50,
);

// fonts

const kMontserratBlackMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold);

const kMontserratWhiteMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold);
const kMontserratWhiteLarge = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold);

const kNormalSansWhiteSmall =
    TextStyle(fontFamily: 'WorkSans', fontSize: 20, color: Colors.white);
const kNormalSansWhiteMini =
    TextStyle(fontFamily: 'WorkSans', fontSize: 15, color: Colors.white);

const kMontserratGraySmall = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    color: kGreyColor,
    fontWeight: FontWeight.bold);

const kNormalMontserratBlackMedium =
    TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.black);

// buttons

BottomAppBar kBottomAppBar(BuildContext context) {
  return BottomAppBar(
    color: Colors.white,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackerPage(),
                ),
              );
            },
            icon: kIconHome),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaderBoardPage(),
                ),
              );
            },
            icon: kIconLeaderboard),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            icon: kIconPerson),
      ],
    ),
  );
}

// Bottom Modal Sheet

//Icons
const Icon kIconHome = Icon(
  Icons.house_outlined,
  color: Colors.black,
  size: 30,
);
const Icon kIconLeaderboard = Icon(
  Icons.leaderboard_outlined,
  color: Colors.black,
  size: 30,
);
const Icon kIconPerson = Icon(
  Icons.person_outline,
  color: Colors.black,
  size: 30,
);
