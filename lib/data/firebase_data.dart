import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings_2/widgets/personalPrompt.dart';

class FirebaseData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userData = FirebaseFirestore.instance.collection('userData');

  late CollectionReference invitesCollection;

  void setInvitesCollection(String userId){
    invitesCollection = userData.doc(userId).collection('invitations');
  }

  // ---------- Savings, Expenses, and Categories Logic  ----------

  Future<void> addSavingsData({
    required String userId,
    required double goal,
    required int days,
    required double budget,
    required double totalAmountSaved,
  }) async {
    try {
      DateTime startDate = DateTime.now();
      DateTime lastUpdatedDate = DateTime.now();

      await userData
          .doc(userId)
          .collection('savings')
          .doc('personal_savings')
          .set({
        'goal': goal,
        'days': days,
        'budget': budget,
        'totalAmountSaved': totalAmountSaved,
        'startDate': startDate,
        'lastUpdatedDate': lastUpdatedDate,
      });
      print('Savings data added successfully for user: $userId');
    } catch (e) {
      print('Error adding savings data: $e');
    }
  }

  void resetSavingsData({required String userId}) async {
    try {
      await userData
          .doc(userId)
          .collection('savings')
          .doc('personal_savings')
          .update({
        'goal': FieldValue.delete(),
        'days': FieldValue.delete(),
        'budget': FieldValue.delete(),
        'totalAmountSaved': FieldValue.delete(),
        'startDate': FieldValue.delete(),
        'lastUpdatedDate': FieldValue.delete(),
      });
    } catch (e) {
      print('Error resetting savings data: $e');
    }
  }

  Stream<DocumentSnapshot<Object?>> fetchSavingsData(String userId) {
    return userData
        .doc(userId)
        .collection('savings')
        .doc('personal_savings')
        .snapshots();
  }

  Future<String?> addExpensesData({
    required String userId,
    required String product,
    required double price,
  }) async {
    try {
      DocumentReference docRef = await userData
          .doc(userId)
          .collection('expenses')
          .add({'product': product, 'price': price});
      print('Expenses data added successfully for user: $userId');
      return docRef.id;
    } catch (e) {
      print('Error adding expenses data: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchExpensesData(String userId) {
    return userData.doc(userId).collection('expenses').snapshots();
  }

  Future<void> updateTotalAmountSaved({
    required String userId,
    required double newTotalAmountSaved,
  }) async {
    try {
      await userData
          .doc(userId)
          .collection('savings')
          .doc('personal_savings')
          .update({'totalAmountSaved': newTotalAmountSaved});
      print('Total saved updated successfully for user: $userId');
    } catch (e) {
      print('Error updating total saved: $e');
    }
  }

  Future<void> updateExpensesData({
    required String userId,
    required String expenseId,
    required String product,
    required double price,
  }) async {
    try {
      await userData
          .doc(userId)
          .collection('expenses')
          .doc(expenseId)
          .update({'product': product, 'price': price});
      print('Expenses data updated successfully for user: $userId');
    } catch (e) {
      print('Error updating expenses data: $e');
    }
  }

  Future<void> deleteExpensesData({
    required String userID,
    required String expenseID,
  }) async {
    try {
      await userData.doc(userID).collection('expenses').doc(expenseID).delete();
    } catch (e) {
      print('Error deleting expense: $e');
    }
  }

  Future<void> addCategoryData({
    required String userID,
    required String category,
    required int priorityLevel,
  }) async {
    try {
      await userData.doc(userID).collection('categories').add({
        'category': category,
        'priority_level': priorityLevel,
      });
      print('Category data added successfully for user: $userID');
    } catch (e) {
      print('Error adding category data: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryData(String userId) {
    return userData.doc(userId).collection('categories').snapshots();
  }

  // ---------- Friend Invitations and Network Logic  ----------

  // Add invite to Firestore
  Future<void> sendFriendInvite({
    required String senderId,
    required String recipientEmail,
    required String senderName,
  }) async {
    try {
      // Ensure invitesCollection is set
      if (invitesCollection == null) {
        setInvitesCollection(senderId);  // Set the collection if not already set
      }

      // Check if recipient exists in the database
      QuerySnapshot recipientSnapshot = await userData.where('email', isEqualTo: recipientEmail).get();

      if (recipientSnapshot.docs.isNotEmpty) {
        // Get recipient ID
        String recipientId = recipientSnapshot.docs.first.id;

        // Create an invite entry
        await invitesCollection.add({
          'senderId': senderId,
          'recipientId': recipientId,
          'status': 'pending',
          'timestamp': FieldValue.serverTimestamp(),
        });

        print('Invite sent to: $recipientEmail');
      } else {
        print('Error: No user found with email $recipientEmail');
      }
    } catch (e) {
      print('Error sending invite: ${e.toString()}');
    }
  }

  // Accept invite
  Future<void> acceptInvite({
    required String inviteId,
    required String userId,
  }) async {
    try {
      // Update invite status to accepted
      await invitesCollection.doc(inviteId).update({
        'status': 'accepted',
        'acceptedAt': FieldValue.serverTimestamp(),
      });

      // Optionally add the user to a 'friends' subcollection
      await userData.doc(userId).collection('friends').doc(inviteId).set({
        'inviteId': inviteId,
        'friendId': userId,
        'friendshipStart': FieldValue.serverTimestamp(),
      });

      print('Invite accepted for user: $userId');
    } catch (e) {
      print('Error accepting invite: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPendingInvites(String userId) {
    return invitesCollection
        .where('recipientId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>;
  }



  // Decline invite
  Future<void> declineInvite({
    required String inviteId,
  }) async {
    try {
      await invitesCollection.doc(inviteId).update({
        'status': 'declined',
      });
      print('Invite declined: $inviteId');
    } catch (e) {
      print('Error declining invite: $e');
    }
  }
}
