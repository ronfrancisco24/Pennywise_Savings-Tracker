import 'package:flutter/material.dart';

void main() {
  CoinChange coinChange =
      CoinChange(availableBudget: 1000.0, targetGoal: 500.0, days: 5);

  // log an expense
  coinChange.logExpense(2, 100);

  // Print the adjusted savings goals for each day
  print("Adjusted daily goals (dp): ${coinChange.dp}");

  // Check if the goal is reachable
  if (coinChange.isGoalReachable()) {
    print('goal is reachable.');
  } else {
    print('goal is not reachable');
  }
}

class CoinChange {
  double availableBudget;
  double targetGoal;
  int days;
  List<double> expenses = []; // array to track expenses
  // dp for dynamic programming
  List<double> dp =
      []; // represents the savings needed, to adjust for savings goal
  double dailyGoal = 0;

  CoinChange(
      {required this.availableBudget,
      required this.targetGoal,
      required this.days}) {
    dailyGoal = targetGoal / days;
    dp = List.filled(days, dailyGoal);
    expenses = List.filled(days, 0);
  }

  void logExpense(int day, double amountSpent) {
    expenses[day] += amountSpent;

    // calculate the excess or shortfall amount for the day
    double difference = (dailyGoal - expenses[day]);

    double totalRemainingGoal = (targetGoal - expenses.reduce((a, b) => a + b));
    double remainingDays = days - day - 1;

    // Update future daily goals if remaining days are positive
    if (remainingDays > 0) {
      double newDailyGoal = totalRemainingGoal / remainingDays;
      for (int i = day + 1; i < days; i++) {
        dp[i] = newDailyGoal;
      }

      // adjust future daily goals based on the difference
      // for (int i = day + 1; i<days;i++){
      //   dp[i] = (dp[i - 1] + difference).clamp(0.0, double.infinity);
      // clamps the values so that it wont go below 0
      // num clamp(num lowerLimit, num upperLimit)
    }

    // dp[i] represents the adjusted savings goal for day i.
    // dp[i - 1]: This gets the previously calculated goal for the day before
    // (the previous day).
    // difference: This is the amount by which the user's expenses exceeded
    // the daily savings goal for the current day.
  }

  double suggestedBudgetForToday(int day) {
    return dp[day]; // return the adjusted savings goal for the current day.
  }

  // to reset expenses for each day
  void resetDailyExpense() {
    for (int i = 0; i < days; i++) {
      expenses[i] = 0;
    }
  }

  bool isGoalReachable() {
    double totalSpent = expenses.reduce((a, b) => a + b); // adds all expenses
    // if total spent is less than availableBudget, goal is still reachable.
    return (availableBudget - totalSpent) >=
        targetGoal; // check if remaining budget meets or exceeds target
  }

  void reset() {
    availableBudget = 0;
    targetGoal = 0;
    days = 0;
  }
}
