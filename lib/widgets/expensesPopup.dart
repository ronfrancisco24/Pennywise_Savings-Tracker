import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';

Dialog expenseOutput(double amountSpent) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 500,
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: kLinearGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('Amount spent: ', style: kNormalSansWhiteMini,),
            Text('₱ ${amountSpent}', style: kNormalSansWhiteMini,),
          ],)

        ],
      ),
    ),
  );
}