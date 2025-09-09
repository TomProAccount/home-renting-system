import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final houses = await FirebaseFirestore.instance.collection('houses').get();

  for (var doc in houses.docs) {
    if (!doc.data().containsKey('createdAt')) {
      await doc.reference.update({'createdAt': FieldValue.serverTimestamp()});
      print('Updated ${doc.id}');
    }
  }

  print('Done updating missing createdAt fields!');
}
