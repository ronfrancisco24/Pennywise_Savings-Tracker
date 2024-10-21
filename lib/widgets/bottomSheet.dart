import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:savings_2/data/firebase_data.dart' as db;
import 'package:savings_2/algorithms/coin_change.dart';

// bottom sheet for adding expenses
Future<void> kAddingBottomSheet({
  required BuildContext context,
  required String userId, // Ensure you pass userId
  required CoinCalculator calculator,
  required int currentDay
}) {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Create an instance of FirebaseData
  final db.FirebaseData firebaseData = db.FirebaseData();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Input Expense',
                  style: kNormalMontserratBlackMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  onPressed: () async {
                    String product = _productController.text;
                    String priceText = _priceController.text;

                    if (product.isNotEmpty && priceText.isNotEmpty) {
                      double? parsedPrice = double.tryParse(priceText);

                      if (parsedPrice != null) {
                        await firebaseData.addExpensesData(
                          userId: userId,
                          product: product,
                          price: parsedPrice,
                          currentDay: currentDay
                        );

                        // update calculator with new expense
                        calculator.addExpense(userId, product, parsedPrice, currentDay);

                        // Optionally close the bottom sheet
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid price")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")));
                    }
                  },
                  child: Icon(Icons.add, color: kBlueColor,),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: kGradientColors,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: _productController,
                            textAlign: TextAlign.center,
                            style: kNormalMontserratBlackMedium,
                            decoration: InputDecoration(
                              hintText: 'Product',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        '₱',
                        style: kNormalMontserratBlackMedium,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: kNormalMontserratBlackMedium,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}

// editing bottom sheet

Future<void> kEditingBottomSheet(
    {required BuildContext context,
    required String userId, // Ensure you pass userId
    required String expenseId,
    required String currentProduct,
    required double currentPrice}) {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Create an instance of FirebaseData
  final db.FirebaseData firebaseData = db.FirebaseData();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Update Expense',
                  style: kNormalMontserratBlackMedium,
                ),
                IconButton(
                  onPressed: () async {
                    String updatedProduct = _productController.text;
                    String priceText = _priceController.text;

                    if (updatedProduct.isNotEmpty && priceText.isNotEmpty) {
                      double? parsedPrice = double.tryParse(priceText);

                      if (parsedPrice != null) {
                        await firebaseData.updateExpensesData(
                            userId: userId,
                            expenseId: expenseId,
                            product: updatedProduct,
                            price: parsedPrice);

                        // Optionally close the bottom sheet
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid price")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")));
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: kGradientColors,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: _productController,
                            textAlign: TextAlign.center,
                            style: kNormalMontserratBlackMedium,
                            decoration: InputDecoration(
                              hintText: 'Product',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        '₱',
                        style: kNormalMontserratBlackMedium,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: kNormalMontserratBlackMedium,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}
