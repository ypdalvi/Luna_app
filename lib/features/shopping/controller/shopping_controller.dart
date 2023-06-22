import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/shopping/repository/shopping_repository.dart';
import 'package:luna/models/product_model.dart';
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

final dealOfTheDayProvider = FutureProvider((ref) {
  final postController = ref.watch(shoppingControllerProvider.notifier);
  return postController.fetchDealOfTheDay();
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

  Future<ProductModel> fetchDealOfTheDay() async {
    final dealOfTheDay = await _shoppingRepository.fetchDealOfTheDay();
    return dealOfTheDay;
  }

  Stream<List<ProductModel>> fetchProducts(String category) {
    return _shoppingRepository.fetchProducts(category);
  }
}
