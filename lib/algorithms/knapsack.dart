class Category {
  String name;
  double savingsGoal;
  double recommendedBudget;
  int priorityLevel;
  double currentBudget;

  Category({
    required this.name,
    required this.savingsGoal,
    required this.priorityLevel,
    required this.currentBudget,
    this.recommendedBudget = 0.0
  });
}

class Expense{
  String productName;
  double price;
  String category;

  Expense({
    required this.productName,
    required this.price,
    required this.category,
  });
}
// The inputs for mainSavings, daysRemaining, availableBudget are fixed for now
double mainSavingsGoal = 1000.0; // TODO: REFERENCE THE VALUE OF THE MAINSAVINGSGOAL
int daysRemaining = 30; // TODO: THIS ONE TOO
double availableBudget = 500.0; // TODO: THIS ONE TOO

List<Category> categories = [
  Category(name: 'Food', savingsGoal: 200.0, priorityLevel: 3, currentBudget: 100.0),
  Category(name: 'Entertainment', savingsGoal: 100.0, priorityLevel: 2, currentBudget: 50.0),
  Category(name: 'Education', savingsGoal: 300.0, priorityLevel: 1, currentBudget: 200.0),
]; // TODO: THESE ONES TOO

List<Expense> expenses =[];

void calculateRecommendedBudget(List<Category> categories, double availableBudget){
  int totalPriorityLevel = categories.fold(0, (sum,category) => sum +category.priorityLevel);
  for (var category in categories){
    category.recommendedBudget = (category.priorityLevel / totalPriorityLevel)*availableBudget;
  }
}

void addExpense(Expense expense) {
  for (var category in categories) {
    if (category.name == expense.category) {
      category.currentBudget -= expense.price;
      availableBudget -= expense.price;
    }
  }
  recalculateDailySavingsGoal();
}

void recalculateDailySavingsGoal() {
  mainSavingsGoal -= expenses.fold(0, (sum, expense) => sum + expense.price);
  if (daysRemaining > 0) {
    double dailySavingsGoal = mainSavingsGoal / daysRemaining;
    print('Updated daily savings goal: ₱${dailySavingsGoal.toStringAsFixed(2)}');
  }
}

//This function is for updating daily budget
void updateDailyBudget(){
  for (var category in categories){
    double remainingGoal = category.savingsGoal - (category.savingsGoal - category.currentBudget);
    double dailyBudget = remainingGoal / daysRemaining;
    print('${category.name} category has ₱${dailyBudget.toStringAsFixed(2)} daily budget left.');
  }
}

//Tracking expenses
void trackExpenses(List<Expense> expenses){
  for (var expense in expenses){
    addExpense(expense);
  }
}

void main(){
  calculateRecommendedBudget(categories, availableBudget);
  print('Initial recommended budgets:');
  for (var category in categories) {
    print('${category.name}: ₱${category.recommendedBudget.toStringAsFixed(2)}');
  }

  // Example of adding expenses
  Expense newExpense = Expense(productName: 'Pizza', price: 20.0, category: 'Food');
  addExpense(newExpense);

  print('After adding expense:');
  updateDailyBudget();
}