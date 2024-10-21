// import 'package:flutter/material.dart';
//
// class EnterInviteCodePage extends StatefulWidget {
//   @override
//   _EnterInviteCodePageState createState() => _EnterInviteCodePageState();
// }
//
// class _EnterInviteCodePageState extends State<EnterInviteCodePage> {
//   final _inviteCodeController = TextEditingController();
//
//   void _submitInviteCode() {
//     String friendInviteCode = _inviteCodeController.text;
//
//     if (friendInviteCode.isNotEmpty) {
//       print("Friend's invite code: $friendInviteCode");
//       _joinLeaderboard(friendInviteCode);
//
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter an invitation code')),
//       );
//     }
//   }
//
//   void _joinLeaderboard(String inviteCode) {
//     print("Joining leaderboard with invite code: $inviteCode");
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter Friend\'s Invitation Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _inviteCodeController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Invitation Code',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.blueAccent[100],
//                 backgroundColor: Colors.white
//               ),
//               onPressed: _submitInviteCode,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }