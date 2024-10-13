import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';
import '../widgets/constants.dart';
import 'tracker.dart';
import 'package:savings_2/authentication/auth_service.dart';

class AllocationPage extends StatefulWidget {
  const AllocationPage({super.key});

  @override
  State<AllocationPage> createState() => _AllocationPageState();
}

class _AllocationPageState extends State<AllocationPage>
    with TickerProviderStateMixin {
  final AuthService authService = AuthService();
  bool _isExpanded = false;
  bool _categoryExpanded = false;
  late AnimationController controller;

  List<String> categories = [];               //List for Categories

  void _toggleExpenses(){
    setState((){
      _isExpanded = !_isExpanded; //toggle if expanded
    });
  }

  void _toggleCategory(){
    setState(()
    {
      _categoryExpanded= !_categoryExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    final user = authService.getCurrentUser();
    int number = 0 ;
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

  void showAnotherPromptPopup(BuildContext context) {
    TextEditingController categoryInputController = TextEditingController();
    TextEditingController priorityLevelController = TextEditingController();

    // Check if category limit is reached

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
                if (categories.length >= 9) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'The limit is 9 categories, please delete one if you want to add more.',

                      ),
                    ),
                  );
                  return; // Exit if limit reached
                }
                String categoryInput = categoryInputController.text;

                setState(() {
                  categories.add(categoryInput); // Add category input
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: kBottomAppBar(context),
        body: SingleChildScrollView(
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
                              const Column(
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
                          const Row(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(                          //Prevents ovelapping of categories
                      spacing: 10,
                      runSpacing: 10,
                      children: categories.map((category) => Container(                         //.map() transforms ech element into a list.
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),            // the => Container() enables list to transform into separate containers.
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(187, 233, 255, 100.0),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3), //  Shadow position
                            ),
                          ],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )).toList(),    //Converts the iterable(results from the .map() into a list.
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: _isExpanded ? double.infinity : 500,
                    height: _isExpanded ? 400 : 60,
                    child: Container( // Toggles expenses expanding
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Expenses'),
                              IconButton(
                                onPressed: () {
                                  _toggleExpenses();
                                },
                                icon: Icon(
                                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                ),
                              ),
                            ],
                          ),
                          if (_isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 400, decoration: BoxDecoration(
                               color: const Color(0xffb1d4e0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  const SizedBox(width:10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Item',
                                        labelStyle: TextStyle(color: Colors.blueGrey),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.5),width:2.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black45, width:2.0),
                                        ),
                                        contentPadding: EdgeInsets.only(bottom:1.0),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width:10),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Category',
                                          labelStyle: TextStyle(color: Colors.blueGrey),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.5),width:2.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black45, width:2.0),
                                          ),
                                          contentPadding: EdgeInsets.only(bottom:1.0),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width:10),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Amount',
                                          labelStyle: TextStyle(color: Colors.blueGrey),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.5),width:2.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black45, width:2.0),
                                          ),
                                          contentPadding: EdgeInsets.only(bottom:1.0),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width:1),
                                    Container(
                                      width:30,
                                      child: ElevatedButton(
                                        onPressed: _toggleCategory,
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(0),
                                          ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width:10),
                                ],
                              ),
                            ),
                          ),
                         ],
                       ),
                     ),
                  ),
                  const SizedBox(height:40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
