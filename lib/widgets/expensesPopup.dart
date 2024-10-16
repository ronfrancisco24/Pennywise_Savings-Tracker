import 'package:flutter/material.dart';
import 'package:savings_2/widgets/constants.dart';

Dialog expenseOutput() {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 500, // Increase width as needed
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: kLinearGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount spent: ', style: kNormalSansWhiteMini,),
          SizedBox(height: 10),
          Text('Current Budget for Today: ', style: kNormalSansWhiteMini),
        ],
      ),
    ),
  );
}