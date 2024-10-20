import 'dart:ffi';

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

class ExpenseData {
  late String item;
  late String category;
  late double amount;
  ExpenseData(
      {required this.item, required this.category, required this.amount});
}

class _AllocationPageState extends State<AllocationPage>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isEditingExpense = false;

  final _itemController = TextEditingController();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();

  final _editItemController = TextEditingController();
  final _editCategoryController = TextEditingController();
  final _editAmountController = TextEditingController();

  late AnimationController controller; //declared variables

  Map<String, int> categoryPriorityMap =
      {}; //Map is used to associated categories with their corresponding priority levels.

  final List<ExpenseData> expenses = []; //expenses list

  List<String> categoryData = <String>[];
  String? _selectedCategory;

  void _toggleExpenses() {
    setState(() {
      _isExpanded = !_isExpanded; // toggle if expanded
    });
  }

  void _addExpense() {
    final String item = _itemController.text;

    final double? amount =
        double.tryParse(_amountController.text); //text controllers

    if (item.isNotEmpty && _selectedCategory != null && amount != null) {
      setState(() {
        expenses
            .add(ExpenseData(item: item, category: _selectedCategory!, amount: amount));
      });


      _itemController.clear();
      _amountController.clear();
      _selectedCategory = null;
      print('item added $item, Amount added: $amount, Category: $_selectedCategory');
    } else{
      print('please enter item, amount, and select a category.');
    }
  }

  void _editExpense(int index) {
    _editItemController.text = expenses[index].item;
    _editCategoryController.text = expenses[index].category;
    _editAmountController.text = expenses[index].amount.toString();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editItemController,
                  decoration: InputDecoration(labelText: 'Item'),
                ),
                TextField(
                  controller: _editCategoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: _editAmountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    expenses[index] = ExpenseData(
                      item: _editItemController.text,
                      category: _editCategoryController.text,
                      amount: double.parse(_editAmountController.text),
                    );
                  });
                  Navigator.of(context).pop();
                  _clearControllers();
                },
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  void _deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  void _clearControllers() {
    _itemController.clear();
    _categoryController.clear();
    _amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    final user = authService.getCurrentUser();
    if (user != null) {
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
                String priorityInput = priorityLevelController.text.trim();

                // Check the limit of 9 categories
                if (categoryPriorityMap.length >= 9) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('The limit is 9 categories.'),
                    ),
                  );
                  return;
                }

                // Check if fields are empty
                if (categoryInput.isEmpty || priorityInput.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                  return;
                }

                // Parse priority input
                int? priorityValue = int.tryParse(priorityInput);
                if (priorityValue == null ||
                    priorityValue < 1 ||
                    priorityValue > 9) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please enter a valid priority between 1 and 9.'),
                    ),
                  );
                  return;
                }

                // Add category to the list and update the map
                setState(() {
                  categoryPriorityMap[categoryInput] = priorityValue;

                  // Assuming categoryData is a list of strings
                  categoryData.add(categoryInput); // Add category to the list
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
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Set horizontal padding
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20), // Add space between elements
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Priority Level: ', style: kNormalSansWhiteMini),
                          Text('${categoryPriorityMap[category] ?? 'N/A'}',
                              style: kNormalSansWhiteMini),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subgoal Target: ', style: kNormalSansWhiteMini),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Recommended Savings: ',
                                style: kNormalSansWhiteMini),
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
          children: [
            SingleChildScrollView(
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
                                          '₽ 0.00',
                                          style: kMontserratWhiteLarge,
                                        ),
                                        Opacity(
                                          opacity: 0.5,
                                          child: Text('Total Saved',
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
                                          'Budget',
                                          style: kNormalSansWhiteMini,
                                        ),
                                        Text(
                                          '₽0.00',
                                          style: kNormalSansWhiteSmall,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Target Goal',
                                          style: kNormalSansWhiteMini,
                                        ),
                                        Text(
                                          '₽0.00',
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
                                    Text("Today's Budget",
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                showAnotherPromptPopup(context);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 20,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(
                                    10), // Control button size through padding
                              ),
                            ),
                          ],
                        ),
                        Text('${categoryData.length}/9')
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
                                      showCategoryDetailsPopup(
                                          context, category);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(187, 233, 255,
                                            1.0), // Corrected opacity
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
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: _isExpanded ? double.infinity : 500,
                              height: _isExpanded
                                  ? 400
                                  : 75, //adjust height here if needed
                              child: Container(
                                // Toggles expenses expanding
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 7),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Expenses',
                                            style: kMontserratBlackMedium),
                                        IconButton(
                                          onPressed: () {
                                            _toggleExpenses();
                                          },
                                          icon: Icon(
                                            _isExpanded
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_isExpanded)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Container(
                                            width: 400,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffb1d4e0),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextField(
                                                    controller: _itemController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Item',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueGrey
                                                                .withOpacity(
                                                                    0.5),
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 2.0),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 1.0),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Category'),
                                                            content: SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: categoryData.isNotEmpty
                                                                    ? categoryData.map((category) {
                                                                  return InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        _selectedCategory = category;  // Save the selected category
                                                                      });
                                                                      print('Category clicked: $category');
                                                                      Navigator.of(context).pop();



                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                      child: Text(
                                                                        category,
                                                                        style: TextStyle(
                                                                          // Styling to show it's clickable
                                                                          fontSize: 16,

                                                                        ),


                                                                      ),
                                                                    ),

                                                                  );
                                                                }).toList()
                                                                    : [
                                                                  Text('No categories available.'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                },
                                                                child: Text('Close'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'Category',
                                                      style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        _amountController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Amount',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueGrey
                                                                .withOpacity(
                                                                    0.5),
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 2.0),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 1.0),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                const SizedBox(width: 1),
                                                Container(
                                                  width: 30,
                                                  child: ElevatedButton(
                                                    onPressed: _isEditingExpense
                                                        ? () {}
                                                        : _addExpense,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(0),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: expenses.length,
                                            itemBuilder: (context, index) {
                                              final expense = expenses[index];
                                              return Card(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            kLinearGradient,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: ListTile(
                                                      title: Text(
                                                        expense.item,
                                                        style:
                                                            kMontserratWhiteMedium,
                                                      ),
                                                      subtitle: Text(
                                                          expense.category,
                                                          style:
                                                              kNormalSansWhiteMini),
                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: Text(
                                                                '\$${expense.amount.toStringAsFixed(2)}',
                                                                style:
                                                                    kNormalSansWhiteMini),
                                                          ),
                                                          PopupMenuButton<
                                                                  String>(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  color: Colors
                                                                      .white),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                      context) {
                                                                return [
                                                                  const PopupMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'edit',
                                                                    child: Text(
                                                                        'Edit'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'delete',
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ];
                                                              },
                                                              onSelected:
                                                                  (value) {
                                                                if (value ==
                                                                    'edit') {
                                                                  _editExpense(
                                                                      index);
                                                                } else if (value ==
                                                                    'delete') {
                                                                  _deleteExpense(
                                                                      index);
                                                                }
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                            })),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
