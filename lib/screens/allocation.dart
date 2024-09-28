import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';
import '../widgets/constants.dart';
import 'tracker.dart';

class AllocationPage extends StatefulWidget {
  const AllocationPage({super.key});

  @override
  State<AllocationPage> createState() => _AllocationPageState();
}

class _AllocationPageState extends State<AllocationPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
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
                    hintText: 'e.g., Buy a new laptop',
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

                print('Target Goal: $targetGoal');
                print('Days To Save: $daysRemaining');
                print('Budget: $budget');

                Navigator.of(context).pop();
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
                'Aaron',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              )
            ],
          ),
        ),
        bottomNavigationBar: kBottomAppBar(context),
        body: Padding(
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackerPage()),
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
                                  'Personal',
                                  style: TextStyle(color: Colors.black),
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
                                    builder: (context) => TrackerPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: kGradientColors,
                              child: Center(
                                child: Text(
                                  'Budget Allocator',
                                  style: TextStyle(color: Colors.white),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$ 260.65',
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
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder()),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: controller.value,
                            semanticsLabel: 'Linear Progress Indicator',
                            backgroundColor: Colors.blue[900],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Target Goal',
                                    style: kNormalSansWhiteMini,
                                  ),
                                  Text(
                                    '\$ 5,000.00',
                                    style: kNormalSansWhiteSmall,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Days Remaining',
                                    style: kNormalSansWhiteMini,
                                  ),
                                  Text(
                                    '7 days',
                                    style: kNormalSansWhiteSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
