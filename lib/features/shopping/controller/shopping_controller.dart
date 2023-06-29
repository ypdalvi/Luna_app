import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/shopping/repository/shopping_repository.dart';
import 'package:luna/models/product_model.dart';
import '../../../core/constants/error_handling.dart';
import '../../../core/providers/storage_repository_provider.dart';

final shoppingControllerProvider =
    StateNotifierProvider<ShoppingController, bool>((ref) {
  final shoppingRepository = ref.watch(shoppingRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ShoppingController(
    shoppingRepository: shoppingRepository,
    storageRepository: storageRepository,
    // ref: ref,
  );
});

final dealOfTheDayProvider = FutureProvider.family((ref, BuildContext context) {
  final postController = ref.watch(shoppingControllerProvider.notifier);
  return postController.fetchDealOfTheDay(context);
});

final productsListProvider = StreamProvider.family((ref, String category) {
  final postController = ref.watch(shoppingControllerProvider.notifier);
  return postController.fetchProducts(category);
});

class ShoppingController extends StateNotifier<bool> {
  final ShoppingRepository _shoppingRepository;
  // final Ref _ref;
  // final StorageRepository _storageRepository;
  ShoppingController({
    required ShoppingRepository shoppingRepository,
    // required Ref ref,
    required StorageRepository storageRepository,
  })  : _shoppingRepository = shoppingRepository,
        // _ref = ref,
        // _storageRepository = storageRepository,
        super(false);

  Future<ProductModel?> fetchDealOfTheDay(BuildContext context) async {
    try {
      final res = await _shoppingRepository.fetchDealOfDay();
      int flag = 0;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          flag = 1;
        },
      );
      if (flag == 1) {
        // print(res.body);
        // final m = json.decode(res.body) as Map<String, dynamic>;
        // print(m['quantity'].runtimeType);
        final product = ProductModel.fromJson(res.body);
        // print("contFetchDealOfDay");
        // print(product.toString());
        return product;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<ProductModel>> fetchProducts(String category) {
    return _shoppingRepository.fetchProducts(category);
  }
}
