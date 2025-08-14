import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection name
  CollectionReference get _usersCollection => _firestore.collection('users');

  /// Add or Update User
  Future<void> saveUserProfile(UserProfile profile) async {
    await _usersCollection.doc().set(profile.toMap());
  }

  /// Get User Profile
  Future<UserProfile?> getUserProfile() async {
    final doc = await _usersCollection.doc().get();
    if (doc.exists) {
      return UserProfile.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<UserProfile>> getAllUsers() async {
    final querySnapshot = await _usersCollection.get();
    return querySnapshot.docs.map((doc) {
      return UserProfile.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
