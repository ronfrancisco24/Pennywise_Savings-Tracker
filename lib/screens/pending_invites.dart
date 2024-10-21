// import 'package:flutter/material.dart';
// import 'package:savings_2/data/firebase_data.dart';
// import 'package:savings_2/authentication/auth_service.dart';
//
// class PendingInvitesScreen extends StatefulWidget {
//   @override
//   _PendingInvitesScreenState createState() => _PendingInvitesScreenState();
// }
//
// class _PendingInvitesScreenState extends State<PendingInvitesScreen> {
//   final FirebaseData firebaseData = FirebaseData();
//   final AuthService authService = AuthService();
//
//   String? userId;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserId();
//   }
//
//   Future<void> _getCurrentUserId() async {
//     userId = await authService.getCurrentUser();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (userId == null) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pending Invites'),
//       ),
//       body: StreamBuilder(
//         stream: firebaseData.fetchPendingInvites(userId!),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           var invites = snapshot.data.docs;
//
//           if (invites.isEmpty) {
//             return Center(child: Text('No pending invites.'));
//           }
//
//           return ListView.builder(
//             itemCount: invites.length,
//             itemBuilder: (context, index) {
//               var invite = invites[index];
//               String inviteId = invite.id;
//               String senderId = invite['senderId'];
//
//               return ListTile(
//                 title: Text('Invite from $senderId'),
//                 subtitle: Text('Status: ${invite['status']}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.check),
//                       onPressed: () async {
//                         await firebaseData.acceptInvite(
//                           inviteId: inviteId,
//                           userId: userId!,
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Invite accepted!')),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () async {
//                         await firebaseData.declineInvite(inviteId: inviteId);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Invite declined.')),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
