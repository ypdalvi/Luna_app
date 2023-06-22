import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/utils.dart';
import 'package:luna/models/product_model.dart';
import 'package:luna/models/rating_model.dart';
import 'package:luna/models/user_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/product_details_repository.dart';
import '../screens/product_details_screen.dart';

final productDetailsControllerProvider = StateProvider((ref) {
  final productDetailsRepository = ref.read(productDetailsRepositoryProvider);
  return ProductDetailsController(
    productDetailsRepository: productDetailsRepository,
    ref: ref,
  );
});

class ProductDetailsController extends StateNotifier<bool> {
  ProductDetailsController({
    required ProductDetailsRepository productDetailsRepository,
    required Ref ref,
  })  : _productDetailsRepository = productDetailsRepository,
        _ref = ref,
        super(false);

  final ProductDetailsRepository _productDetailsRepository;
  final Ref _ref;

  void addToCart(UserModel user, String pid, BuildContext context) async {
    try {
      var cart = _ref.read(userModelProvider)!.cart;

      cart.update(
        pid,
        (value) => value + 1,
        ifAbsent: () => 1,
      );

      _ref
          .read(userModelProvider.notifier)
          .update((state) => state!.copyWith(cart: cart));
      await _productDetailsRepository.addToCart(user);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void rateProduct(ProductModel product, String uid, double rating,
      BuildContext context) async {
    var i = product.rating.indexWhere((element) => element.userId == uid);

    if (i != -1) {
      product.rating[i] = product.rating[i].copyWith(rating: rating);
    } else {
      product.rating.add(RatingModel(userId: uid, rating: rating));
    }
    calculateRating(product);
    try {
      await _productDetailsRepository.rateProduct(product);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void calculateRating(ProductModel product) {
    _ref.read(avgRatingProvider.notifier).update((state) => 0);
    _ref.read(totalRatingProvider.notifier).update((state) => 0);
    _ref.read(myRatingProvider.notifier).update((state) => 0);
    for (int i = 0; i < product.rating.length; i++) {
      _ref
          .read(totalRatingProvider.notifier)
          .update((state) => state += product.rating[i].rating);
      if (product.rating[i].userId == _ref.read(userModelProvider)!.uid) {
        _ref
            .read(myRatingProvider.notifier)
            .update((state) => product.rating[i].rating);
      }
    }
    final tr = _ref.read(totalRatingProvider);
    if (tr != 0) {
      _ref
          .read(avgRatingProvider.notifier)
          .update((state) => tr / product.rating.length);
    }
  }
}
