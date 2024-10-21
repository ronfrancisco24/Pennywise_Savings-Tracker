import 'package:flutter/material.dart';
import 'package:savings_2/data/firebase_data.dart';
import 'package:savings_2/authentication/auth_service.dart';

final FirebaseData fireStore = FirebaseData();
final AuthService authService = AuthService();

final user = authService.getCurrentUser();
final userID = user?.uid.toString();

void showPromptPopup(BuildContext context) {
  TextEditingController targetGoalController = TextEditingController();
  TextEditingController daysRemainingController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  String errorMessage = ''; // State variable for error messages

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
              SizedBox(height: 10),
              // Display error message
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
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

              // Convert string inputs to their valid data types.
              double? goal = double.tryParse(targetGoal);
              int? days = int.tryParse(daysRemaining);
              double? budgetValue = double.tryParse(budget);
              double totalSaved = 0;

              if (goal != null && days != null && budgetValue != null) {
                // Check for conditions and update error message if necessary
                if (budgetValue < goal) {
                  errorMessage = 'The target goal cannot be lower than the budget.';
                } else if (days > 30) {
                  errorMessage = 'Days remaining cannot exceed 30.';
                } else {
                  // Clear error message if everything is valid
                  errorMessage = '';
                  fireStore.addSavingsData(
                    userId: userID.toString(),
                    goal: goal,
                    days: days,
                    budget: budgetValue,
                    totalAmountSaved: totalSaved,
                  );
                  Navigator.of(context).pop(); // Close the dialog after successful submission
                  return; // Exit early to prevent the dialog from closing prematurely
                }
              } else {
                errorMessage = 'Please enter valid numbers for goal, days, and budget.';
              }

              // Trigger a rebuild to show the error message
              (context as Element).markNeedsBuild();
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
