import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseData {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addSavingsData({String? userId, int? goal, int? days, int? budget}) async {
    try {
      Map<String, dynamic> data = {
        'userId': userId,
        'goal': goal,
        'dayş': days,
        'budget': budget
      };
      await db.collection('savings').add(data);
    } catch (e) {
      print('Error importing data.');
    }
  }

  Future<void> fetchSavingsData() async {

    try {
      QuerySnapshot querySnapshot = await db.collection('savings').get();

      // access different fields in docs

      for (var doc in querySnapshot.docs){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        int goal = data['goal'];
        int days = data['days'];
        int budget = data['budget'];

        print('budget:$budget, days:$days, goal:$goal}');
      }

    } catch(e){
        print('Error fetching data.');
    }
}

}


