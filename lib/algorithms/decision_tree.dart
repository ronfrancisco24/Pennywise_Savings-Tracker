class DecisionTree {
  // Evaluate current spending against the daily budget and savings goal
  String evaluate(double currentSpending, double dailyBudget, double savingsGoal) {
    // If spending exceeds the budget
    if (currentSpending > dailyBudget) {
      return 'Reduce Spending';
    }
    // If spending is less than the daily budget and there is a savings goal
    if (currentSpending < dailyBudget && savingsGoal > 0) {
      return 'Increase Savings';
    }
    // If spending is on target or within the budget
    return 'Maintain Current Budget';
  }
}

//TODO: if one condition is true, we return some kind of dialog to show..