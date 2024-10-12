import 'package:flutter/material.dart';
import 'constants.dart';

Future<void> kBottomSheet({
  required BuildContext context,
  required double budget,
  required double price,
}) {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                IconButton(onPressed: () {}, icon: Icon(Icons.add))
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
