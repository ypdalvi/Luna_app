import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/constants/firebase_constants.dart';
import 'package:luna/core/providers/firebase_providers.dart';
import 'package:luna/models/product_model.dart';
import 'package:luna/models/user_model.dart';

final productDetailsRepositoryProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ProductDetailsRepository(firestore: firestore);
});

class ProductDetailsRepository {
  ProductDetailsRepository({
    required this.firestore,
  });
  FirebaseFirestore firestore;

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);

  CollectionReference get _products =>
      firestore.collection(FirebaseConstants.productCollection);

  Future<void> addToCart(UserModel user) async {
    try {
      await _users.doc(user.uid).update({
        'cart': user.cart,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rateProduct(ProductModel product) async {
    try {
      await _products.doc(product.pid).update({
        'rating': product.rating.map((e) => e.toMap()).toList(),
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
