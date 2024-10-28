import 'package:savings_2/data/expense.dart';
import 'decision_tree.dart';

class CoinCalculator {
  double availableBudget;
  double targetGoal;
  int days;
  List<Expense> expenses = [];
  List<double> dailyBudgets = [];
  List<double> dailySavings = [];
  double totalSaved = 0;
  DateTime startDate;

  DecisionTree decisionTree = DecisionTree();

  CoinCalculator({
    required this.availableBudget,
    required this.targetGoal,
    required this.days,
  }) : startDate = DateTime.now() {
    calculateDailyGoal();
    calculateDailyBudgets();
  }

  // Initialize daily goals for each day
  List<double> calculateDailyGoal() {
    double dailyGoal = targetGoal / days;
    // Fill list with daily goal for each day
    for (int i = 0; i < days; i++) {
      dailySavings.add(dailyGoal);
    }
    return dailySavings;
  }

  // Initialize daily budgets for each day
  List<double> calculateDailyBudgets() {
    double dailyBudget = (availableBudget - targetGoal) / days;
    // Fill list with daily budget for each day
    for (int i = 0; i < days; i++) {
      dailyBudgets.add(dailyBudget);
    }
    return dailyBudgets;
  }

  void adjustBudgetsAndGoals() {
    int currentDay =
        expenses.length - 1; // Get the current day index based on expenses
    int remainingDays =
        days - (currentDay + 1); // Calculate the remaining days after today
    if (expenses[currentDay].price == 0)
      return; // No expenses to adjust against

    double currentSpending = expenses[currentDay].price;

    // keep track of expense on last day, whether if target is reachable based on expense
    if (currentDay == days - 1) {
      adjustForLastDay();
    } else if (remainingDays > 0) {
      double extra = expenses[currentDay].price - dailyBudgets[currentDay];
      double adjustment = extra / remainingDays;

      // Adjust the subsequent days' budgets and goals
      for (int i = currentDay + 1; i < days; i++) {
        dailyBudgets[i] -= adjustment; // Decrease budget for subsequent days
        dailySavings[i] +=
            adjustment; // Increase savings goal for subsequent days
        decisionTree.evaluate(currentSpending, dailyBudgets[i],
            dailySavings[i]); // evaluates spendings.
      }
    }
  }

  void adjustForLastDay() {
    int lastDay = days - 1; // Get the last day index
    double lastExtra = 0;

    // Check if the last day's spending exceeds the budget
    if (expenses.length > lastDay && dailyBudgets[lastDay] < expenses[lastDay].price) {
      lastExtra = expenses[lastDay].price - dailyBudgets[lastDay]; // Calculate the extra spending

      // Adjust the last day's budget and savings goal
      dailyBudgets[lastDay] -= lastExtra; // Decrease the budget for the last day
      dailySavings[lastDay] += lastExtra; // Increase the savings goal for the last day
    }
  }

  // Method to add an expense
  void addExpense(String id, String name, double amount, int day) {
    if (day >= 0 && day < days) {
      expenses.add(Expense(id: id, product: name, price: amount));
      adjustBudgetsAndGoals(); // Adjust values after adding expense
    } else {
      print('invalid index.');
    }
  }

  // will adjust if an expense has been deleted.
  void deleteExpense(String expenseId) {
    expenses.removeWhere((expense) =>
        expense.id == expenseId); // Assume Expense has an id property
    adjustBudgetsAndGoals();
    // Optionally recalculate your budget and goals here
  }

  void calculateSavings(int currentDay) {
    if (currentDay >= 0 && currentDay < days) {
      // Sum up all savings from previous days (including today)
      totalSaved = dailySavings.sublist(0, currentDay + 1).reduce((a, b) => a + b);
    } else {
      print("Invalid day index for savings calculation.");
    }
  }

  // Calculate the total amount spent so far
  double amountSpent() {
    return expenses.fold(0, (sum, expense) => sum + expense.price);
  }

  // Check if the savings goal is still reachable
  bool isGoalReachable() {
    double totalExpenses = amountSpent();
    double remainingBudget = availableBudget - totalExpenses;
    return remainingBudget >= targetGoal;
  }

  // Method to display progress as a linear bar
  void displayProgress() {
    double progressPercentage = (totalSaved / targetGoal) * 100;
    int barLength = 20; // Length of the progress bar
    int filledLength = (barLength * progressPercentage / 100).round();
    String bar = '█' * filledLength + '-' * (barLength - filledLength);

    print('Savings Progress: |$bar| $progressPercentage%');
  }
}

void main() {
  // Example usage
  var calculator = CoinCalculator(
    availableBudget: 400,
    targetGoal: 300,
    days: 2,
  );

  // Initial values before any expense
  print('Initial Daily Goals: ${calculator.dailySavings}');
  print('Initial Daily Budgets: ${calculator.dailyBudgets}');
  print('Initial Total Saved: ${calculator.totalSaved}');
  // Simulate expenses
  calculator.addExpense('001', 'Coffee', 43, 0); // day 1
  calculator.addExpense('001', 'Coffee', 100, 0); // day 1
  calculator.addExpense('001', 'Coffee', 43, 1); // day 1

  // Recalculate values after the expenses
  print('Daily Goals after expenses: ${calculator.dailySavings}');
  print('Daily Budgets after expenses: ${calculator.dailyBudgets}');
  print('Total Saved after expenses: ${calculator.totalSaved}');
  print('Is goal reachable? ${calculator.isGoalReachable()}');
}
