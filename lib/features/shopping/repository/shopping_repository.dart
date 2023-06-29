import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/constants/error_handling.dart';
import 'package:luna/models/product_model.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import 'package:http/http.dart' as http;

final shoppingRepositoryProvider = Provider((ref) {
  return ShoppingRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class ShoppingRepository {
  final FirebaseFirestore _firestore;
  ShoppingRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // CollectionReference get _productOfTheDay =>
  //     _firestore.collection(FirebaseConstants.productOfTheDayCollection);

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

  Future<http.Response> fetchDealOfDay() async {
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/dealOfTheDay'));
      return res;
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
