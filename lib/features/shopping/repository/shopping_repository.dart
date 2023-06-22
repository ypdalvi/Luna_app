import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/models/product_model.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';

final shoppingRepositoryProvider = Provider((ref) {
  return ShoppingRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class ShoppingRepository {
  final FirebaseFirestore _firestore;
  ShoppingRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _productOfTheDay =>
      _firestore.collection(FirebaseConstants.productOfTheDayCollection);

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

  Future<ProductModel> fetchDealOfTheDay() async {
    try {
      final product = await _productOfTheDay
          .doc()
          .snapshots()
          .map(
            (event) =>
                ProductModel.fromMap(event.data() as Map<String, dynamic>),
          )
          .first;
      return product;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchProducts(String category) {
    return _products
        .where("category", isEqualTo: category)
        .snapshots()
        .map((event) => event.docs
            .map<ProductModel>(
              (e) => ProductModel.fromMap(
                e.data() as Map<String, dynamic>,
              ),
            )
            .toList());
  }
}
