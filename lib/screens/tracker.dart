import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:savings_2/screens/allocation.dart';
import 'package:savings_2/widgets/constants.dart';
import 'home_page.dart';
import 'package:savings_2/authentication/auth_service.dart';
import 'package:savings_2/data/firebase_data.dart';
import 'package:savings_2/widgets/bottomSheet.dart';

final expenses = [
  // Add more expenses here
  const MapEntry("Dynamic", 25.50),
  const MapEntry("Items", 35.00),
];

class TrackerPage extends StatefulWidget {
  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final AuthService authService = AuthService();
  final FirebaseData fireStore = FirebaseData();
  late String userID;

  @override
  void initState() {
    super.initState();
    final user = authService.getCurrentUser();

    if (user != null) {
      userID = user.uid.toString();

      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 5),
      )..addListener(() {
          setState(() {});
        });
      controller.repeat(reverse: false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showPromptPopup(BuildContext context) {
    TextEditingController targetGoalController = TextEditingController();
    TextEditingController daysRemainingController = TextEditingController();
    TextEditingController budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Enter Your Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: targetGoalController,
                  decoration: InputDecoration(
                    labelText: 'Target Goal',
                    hintText: 'e.g., 5000',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: daysRemainingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Days To Save',
                    hintText: 'e.g., 30',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Budget',
                    hintText: 'e.g., 1000',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Retrieve and use values as needed
                String targetGoal = targetGoalController.text;
                String daysRemaining = daysRemainingController.text;
                String budget = budgetController.text;

                // Convert string inputs to integers
                int? goal = int.tryParse(targetGoal);
                int? days = int.tryParse(daysRemaining);
                int? budgetValue = int.tryParse(budget);

                if (goal != null && days != null && budgetValue != null) {
                  fireStore.addSavingsData(
                    userId: userID,
                    goal: goal,
                    days: days,
                    budget: budgetValue,
                  );

                  print('Target Goal: $targetGoal');
                  print('Days To Save: $daysRemaining');
                  print('Budget: $budget');
                } else {
                  print(
                      'Please enter valid numbers for goal, days, and budget.');
                }
                Navigator.of(context)
                    .pop(); // Close the dialog after submission
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = authService.getUserName();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffebedf0),
        appBar: AppBar(
          backgroundColor: Color(0xffebedf0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Good Morning, ',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${username}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              )
            ],
          ),
        ),
        bottomNavigationBar: kBottomAppBar(context),
        body: StreamBuilder<DocumentSnapshot>(
            stream: fireStore.fetchSavingsData(userID),
            builder: (context, snapshot) {
              int goal = 0; // Default value
              int days = 0; // Default value
              int budget = 0; // Default value

              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                print('No document exists, using default values.');
              } else {
                final data = snapshot.data!.data() as Map<String, dynamic>?;

                // Use data if available
                if (data != null) {
                  goal = data['goal'] ?? 0;
                  days = data['days'] ?? 0;
                  budget = data['budget'] ?? 0;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    height: 50,
                                    decoration: kGradientColors,
                                    child: Center(
                                      child: Text(
                                        'Personal',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllocationPage()),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xffb1d4e0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Budget Allocator',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(15),
                            decoration: kGradientColors,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$ ${budget}',
                                          style: kMontserratWhiteLarge,
                                        ),
                                        Opacity(
                                          opacity: 0.5,
                                          child: Text('Total Balance',
                                              style: kMontserratGraySmall),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showPromptPopup(context);
                                      },
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: Colors.black,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                LinearProgressIndicator(
                                  value: controller.value,
                                  semanticsLabel: 'Linear Progress Indicator',
                                  backgroundColor: Colors.blue[900],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Target Goal',
                                          style: kNormalSansWhiteMini,
                                        ),
                                        Text(
                                          '\$ ${goal.toString()}',
                                          style: kNormalSansWhiteSmall,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Days Remaining',
                                          style: kNormalSansWhiteMini,
                                        ),
                                        Text(
                                          '${days} days',
                                          style: kNormalSansWhiteSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: kGradientColors,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Today's Target",
                                    style: kMontserratWhiteMedium),
                                Text(
                                  '\$ 200.00',
                                  style: kMontserratWhiteMedium,
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Expenses',
                                  style: kMontserratBlackMedium),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      kBottomSheet(
                                          context: context,
                                          budget: 3.0,
                                          price: 2.0);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(expenses[index].key,
                                    style: kNormalMontserratBlackMedium),
                                Text("\$${expenses[index].value}",
                                    style: kNormalMontserratBlackMedium),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
