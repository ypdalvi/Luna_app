import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/models/product_model.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';

final adminRepositoryProvider = Provider((ref) {
  return AdminRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class AdminRepository {
  final FirebaseFirestore _firestore;
  AdminRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.productCollection);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Future<void> addProduct(ProductModel product) async {
    try {
      return _posts.doc(product.pid).set(product.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      rethrow;
    }
  }
}
