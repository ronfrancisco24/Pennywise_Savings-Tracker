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
          .doc('personal_savings')
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
  //TODO Step 1. add data in product.
  Future<String?> addExpensesData({
    required String userId,
    required String product,
    required double price

  }) async {
    try {
      DocumentReference docRef = await userData
          .doc(userId)
          .collection('expenses')
          .add({'product': product, 'price': price});
      print('Expenses data added successfully for user: $userId');
      return docRef.id;

    } catch (e) {
      print('Error adding savings data: $e');
    }
  }

  // fetches expenses data
  //TODO Step 2. update data in product.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchExpensesData(String userId) {
    return userData
        .doc(userId)
        .collection('expenses').snapshots();
  }

  // update data

  Future<void> updateExpensesData({
    required String userId,
    required String expenseId,
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
