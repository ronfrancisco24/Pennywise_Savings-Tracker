import 'package:cloud_firestore/cloud_firestore.dart';

class Invite {
  final String senderId;
  final String recipientEmail;
  final String status;
  final Timestamp timestamp;

  Invite({
    required this.senderId,
    required this.recipientEmail,
    required this.status,
    required this.timestamp,
  });

  factory Invite.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Invite(
      senderId: data['senderId'] ?? '',
      recipientEmail: data['recipientEmail'] ?? '',
      status: data['status'] ?? 'pending',
      timestamp: data['timestamp'],
    );
  }
}
