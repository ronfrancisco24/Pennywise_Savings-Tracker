import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:savings_2/screens/allocation.dart';
import 'package:savings_2/widgets/constants.dart';
import 'package:savings_2/authentication/auth_service.dart';
import 'package:savings_2/data/firebase_data.dart';
import 'package:savings_2/widgets/bottomSheet.dart';
import 'package:savings_2/widgets/personalPrompt.dart';

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
      // controller.repeat(reverse: false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

            // Default values
            int goal = 0;
            int days = 0;
            int budget = 0;

            // check connection state

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

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
                                        builder: (context) => AllocationPage()),
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
                                        '\$ ${budget.toStringAsFixed(2)}',
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
                                        '\$ ${goal.toStringAsFixed(2)}',
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Today's Target",
                                      style: kMontserratWhiteMedium),
                                  Text(
                                    '\$ 0',
                                    style: kMontserratWhiteMedium,
                                  )
                                ],
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Expenses',
                                style: kMontserratBlackMedium),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    kAddingBottomSheet(
                                        context: context, userId: userID);
                                  },
                                  child: Icon(
                                    Icons.add,
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
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: fireStore.fetchExpensesData(userID),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          print('snapshot ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          print('No expenses data found.');
                        }

                        var expenses = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            // Ensure expenses[index] is not null
                            if (expenses[index] == null) {
                              return SizedBox.shrink(); // Return an empty widget if the expense is null
                            }

                            var expenseData = expenses[index].data();

                            // Check if expenseData is not null
                            if (expenseData == null) {
                              return SizedBox.shrink(); // Return an empty widget if the expenseData is null
                            }

                            String product = expenseData[
                                'product']; // takes the product field
                            double price =
                                expenseData['price']; // takes the price field
                            var expenseID = expenses[index].id;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(product,
                                        style: kNormalMontserratBlackMedium),
                                  ),
                                  Expanded(
                                    child: Text('\$${price.toStringAsFixed(2)}',
                                        style: kNormalMontserratBlackMedium),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await kEditingBottomSheet(
                                      context: context, // Pass the context
                                      userId: userID, // Ensure you pass the user ID
                                      expenseId: expenseID, // Pass the expense ID
                                      currentProduct: product, // Pass the current product name
                                      currentPrice: price, // Pass the current price
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await fireStore.deleteExpensesData(userID: userID, expenseID: expenseID);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
