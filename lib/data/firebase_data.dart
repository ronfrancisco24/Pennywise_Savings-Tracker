import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseData {
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');

  Future<void> addSavingsData({
    required String userId,
    required int goal,
    required int days,
    required int budget,
  }) async {
    try {
      await userData
          .doc(userId)
          .collection('savings')
          .doc('user_savings')
          .set({'goal': goal, 'days': days, 'budget': budget});
      print('Savings data added successfully for user: $userId');
    } catch (e) {
      print('Error adding savings data: $e');
    }
  }

  Stream<DocumentSnapshot<Object?>> fetchSavingsData(String userId) {
    return userData
        .doc(userId)
        .collection('savings')
        .doc('personal_savings')
        .snapshots();
  }



  // adds expenses data

  Future<void> addExpensesData({
    required String userId,
    required String product,
    required double price
  }) async {
    try {
      await userData
          .doc(userId)
          .collection('expenses')
          .doc('personal_expenses')
          .set({'product': product, 'price': price});
      print('Expenses data added successfully for user: $userId');
    } catch (e) {
      print('Error adding savings data: $e');
    }
  }

  // fetches expenses data

  Stream<DocumentSnapshot<Object?>> fetchExpensesData(String userId) {
    
    int num = 1;
    return userData
        .doc(userId)
        .collection('expenses')
        .doc('user_expenses')
        .snapshots();
  }

  // update data

  Future<void> updateExpensesData({
    required String userId,
    required String product,
    required double price
  }) async {
    try {
      await userData
          .doc(userId)
          .collection('expenses')
          .doc('personal_expenses')
          .update({'product': product, 'price': price});
      print('Expenses data added successfully for user: $userId');
    } catch (e) {
      print('Error adding savings data: $e');
    }
  }
}
