import 'package:flutter/material.dart';

class coinChange {

  double currentBudget = 1000;
  int days = 10;
  List<double> expenses = List.filled(10, 0);
  List<double> dp = List.filled(10, 0);
  double dailyGoal = 0;

  CoinChange(){
    dailyGoal = currentBudget / days;

    for (int i =0; i < days; i++){
      dp[i] = dailyGoal; // initialize the dp list with the daily goal for each day
    }
  }

  // calculate the remaning goal
  void calculateDailyGoal(double totalGoal, double currentBudget, int remainingDays){


  }

  void logExpense(int day, double amountSpent){
    expenses[day] += amountSpent;

    // calculate the excess amount for the day
    double difference = (dailyGoal - expenses[day]);

    // adjust future days based on the difference
    for (int i = day + 1; i<days;i++){
      dp[i] = dp[i-1] + difference;
    }
  }

  double suggestedBudgetForToday(int day){
    if (day == 0)
      return dailyGoal; // initial daily goal for the first day
    return dp[day - 1]; // adjusted budget for each day based on the spendings.
  }

  // to reset expenses for each day
  void resetDailyExpense(){
    for (int i = 0; i < days; i++){
      expenses[i];
    }
  }
}