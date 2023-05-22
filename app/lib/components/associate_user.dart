import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void associateUserWithPerson() async {
  final user = FirebaseAuth.instance.currentUser;
  final userId = user!.uid;

  final personCollection = FirebaseFirestore.instance.collection('Person');
  final personDoc =
      await personCollection.where('userId', isEqualTo: userId).get();

  if (personDoc.docs.isNotEmpty) {
    // User is already associated with a Person document
    return;
  }

  final userRef = personCollection.doc(userId);
  await userRef.set({
    'userId': userId,
  });

  final userCollection = FirebaseFirestore.instance.collection('User');
  final userDoc = await userCollection.doc(userId).get();

  if (!userDoc.exists) {
    // Create the User document if it doesn't exist
    await userCollection.doc(userId).set({
      'person': userRef,
      'email': user.email,
    });
  }
}
