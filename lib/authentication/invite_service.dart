import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings_2/algorithms/invite.dart';

class InviteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to retrieve pending invites
  Future<List<Invite>> getPendingInvites() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("User is not authenticated. Cannot retrieve invites.");
      return [];
    }

    List<Invite> pendingInvites = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('invites')
          .where('recipientEmail', isEqualTo: currentUser.email) // Use current user's email
          .where('status', isEqualTo: 'pending')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No pending invites found for ${currentUser.email}");
      } else {
        for (var doc in querySnapshot.docs) {
          pendingInvites.add(Invite.fromFirestore(doc)); // Assuming Invite has a fromFirestore method
        }
        print("${pendingInvites.length} pending invites found for ${currentUser.email}");
      }
    } catch (e) {
      print("Error retrieving pending invites: $e");
    }
    return pendingInvites;
  }
}
