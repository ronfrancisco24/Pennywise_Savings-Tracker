import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:savings_2/data/firebase_data.dart'
    as db; // Import your FirebaseData file

Future<void> kBottomSheet({
  required BuildContext context,
  required double budget,
  required double price,
  required String userId, // Ensure you pass userId
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
                IconButton(
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
                        );

                        // Optionally close the bottom sheet
                        Navigator.of(context).pop();
                      } else {
                        print("Invalid price");
                      }
                    } else {
                      print("Please fill in all fields");
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
