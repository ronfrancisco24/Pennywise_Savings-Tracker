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
    for (int i = 0; i < days; i++){
      dailySavings.add(dailyGoal);
    }
    return dailySavings;
  }

  // Initialize daily budgets for each day
  List<double> calculateDailyBudgets() {
    double dailyBudget = (availableBudget - targetGoal) / days;
     // Fill list with daily budget for each day
    for (int i = 0; i < days; i++){
      dailyBudgets.add(dailyBudget);
    }
    return dailyBudgets;
  }

  void adjustBudgetsAndGoals() {

    int currentDay = expenses.length - 1; // Get the current day index based on expenses
    int remainingDays = days - (currentDay + 1); // Calculate the remaining days after today
    if (expenses[currentDay].price == 0) return; // No expenses to adjust against

    double currentSpending = expenses[currentDay].price;

    // keep track of expense on last day, whether if target is reachable based on expense
    if (currentDay == days - 1){
        double lastExtra = currentSpending - dailyBudgets[currentDay];
        double adjustment = lastExtra / (remainingDays + 1);

        // Adjust the last day's budget and savings goal
        dailyBudgets[currentDay] -= adjustment; // Decrease budget for last day
        dailySavings[currentDay] += adjustment; // Increase savings goal for last day
    } else if (remainingDays > 0) {
      double extra = expenses[currentDay].price - dailyBudgets[currentDay];
      double adjustment = extra / remainingDays;

      // Adjust the subsequent days' budgets and goals
      for (int i = currentDay + 1; i < days; i++) {
        dailyBudgets[i] -= adjustment; // Decrease budget for subsequent days
        dailySavings[i] += adjustment; // Increase savings goal for subsequent days
        decisionTree.evaluate(currentSpending, dailyBudgets[i], dailySavings[i]); // evaluates spendings.
      }
    }
  }

  // Method to add an expense
  void addExpense(String id, String name, double amount, int day) {
    if (day >= 0 && day < days){
      expenses.add(Expense(id: id, product: name, price: amount));
      adjustBudgetsAndGoals(); // Adjust values after adding expense
    } else {
      print('invalid index.');
    }

  }

  void calculateSavings(){
    totalSaved = dailySavings.reduce((a, b) => a + b); // adds daily savings to total saved.
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
  calculator.calculateSavings();

  // Recalculate values after the expenses
  print('Daily Goals after expenses: ${calculator.dailySavings}');
  print('Daily Budgets after expenses: ${calculator.dailyBudgets}');
  print('Total Saved after expenses: ${calculator.totalSaved}');
  print('Is goal reachable? ${calculator.isGoalReachable()}');
}
