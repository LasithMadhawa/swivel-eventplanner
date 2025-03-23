import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  Future<UserModel> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) throw const UserNotFoundFailure();
      return UserModel.fromMap(doc.data()!);
    } on FirebaseException catch (e) {
      throw DatabaseFailure(message: 'Failed to get user: ${e.message}');
    } catch (e) {
      throw const DatabaseFailure(message: 'Failed to get user data');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(
            user.toMap(),
            SetOptions(merge: true),
          );
    } on FirebaseException catch (e) {
      throw DatabaseFailure(message: 'Failed to save user: ${e.message}');
    } catch (e) {
      throw const DatabaseFailure(message: 'Failed to save user data');
    }
  }

  Future<String> uploadProfileImage(String userId, XFile image) async {
    try {
      final ref = _storage.ref().child('profile_pictures/$userId');
      await ref.putData(await image.readAsBytes());
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Image upload failed: ${e.toString()}');
    }
  }

  Future<bool> isProfileComplete(String userId) async {
    try {
      final user = await getUser(userId);
      return user.firstName != null &&
          user.lastName != null &&
          user.phoneNumber != null&&
          user.address != null;
    } on UserNotFoundFailure {
      return false;
    } catch (e) {
      return false;
    }
  }
}
