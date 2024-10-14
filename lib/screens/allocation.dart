import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';
import 'package:savings_2/widgets/personalPrompt.dart';
import 'tracker.dart';
import 'package:savings_2/authentication/auth_service.dart';

class AllocationPage extends StatefulWidget {

  final AuthService authService = AuthService();

  @override
  State<AllocationPage> createState() => _AllocationPageState();
}

class _AllocationPageState extends State<AllocationPage>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _categoryExpanded = false;
  late AnimationController controller;


  Map<String, int> categoryPriorityMap = {}; //Map is used to associated categories with their corresponding priority levels.

  void _toggleExpenses() {
    setState(() {
      _isExpanded = !_isExpanded; // toggle if expanded
    });
  }

  void _toggleCategory() {
    setState(() {
      _categoryExpanded = !_categoryExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    final user = authService.getCurrentUser();
    if (user != null){
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 5),
      )..addListener(() {
        setState(() {});
      });
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
                    hintText: 'e.g., Buy a new laptop ',
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

  void showAnotherPromptPopup(BuildContext context) {
    TextEditingController categoryInputController = TextEditingController();
    TextEditingController priorityLevelController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Enter a Category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: categoryInputController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'e.g., School',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priorityLevelController,
                  decoration: InputDecoration(
                    labelText: 'Priority Level',
                    hintText: 'e.g., 1-9',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
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
                String categoryInput = categoryInputController.text.trim();
                String priorityInput = priorityLevelController.text.trim(); //ensures that there is no unwanted space in the input

                if (categoryPriorityMap.length >= 9) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('The limit is 9 categories.'),
                    ),
                  );
                  return;
                }

                if (categoryInput.isEmpty || priorityInput.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                  return;
                }

                int? priorityValue = int.tryParse(priorityInput);          //Parses the string into int
                if (priorityValue == null || priorityValue < 1 || priorityValue > 9) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid priority between 1 and 9.'),
                    ),
                  );
                  return;
                }

                setState(() {
                  categoryPriorityMap[categoryInput] = priorityValue;
                });

                print('Category: $categoryInput');
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Function to display popup when a category is tapped
  void showCategoryDetailsPopup(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          title: SingleChildScrollView(
            child: Container(
              decoration: kGradientColors,
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Set horizontal padding
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$category',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20), // Add space between elements
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Priority Level: ',
                            style: kNormalSansWhiteMini
                          ),
                          Text(
                            '${categoryPriorityMap[category] ?? 'N/A'}',
                            style: kNormalSansWhiteMini
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Subgoal Target: ',
                              style: kNormalSansWhiteMini
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                'Recommended Savings: ',
                                style: kNormalSansWhiteMini
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Adjust spacing
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: kNormalSansWhiteSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
        body: ListView(
          children: [ SingleChildScrollView(
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$ 0',
                                      style: kMontserratWhiteLarge,
                                    ),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text('Total Budget',
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
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
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
                                      '\$ 0',
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
                                      '0 days',
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Suggested Budget",
                                    style: kMontserratWhiteMedium),
                                Text(
                                  '\$ 0',
                                  style: kMontserratWhiteMedium,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            showAnotherPromptPopup(context);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 16,
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              minimumSize: Size(30, 30)),
                        ),
                      ],
                    ),
                    Text('0/9')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categoryPriorityMap.keys
                            .map(
                              (category) => GestureDetector(
                            onTap: () {
                              showCategoryDetailsPopup(context, category);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(187, 233, 255, 1.0), // Corrected opacity
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Container(
                      width: _isExpanded ? double.infinity : 500,
                      height: _isExpanded ? 200 : 60,
                      child: ElevatedButton(
                        onPressed: _toggleExpenses,
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(_isExpanded ? 20 : 20),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Expenses'),
                                Icon(
                                  _isExpanded
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                            if (_isExpanded)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: _toggleCategory,
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Item'),
                                          )),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _toggleCategory,
                                        child: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('Category'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _toggleCategory,
                                        child: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('Amount'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
