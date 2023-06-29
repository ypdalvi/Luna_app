import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/shopping/controller/shopping_controller.dart';
import 'package:luna/models/product_model.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../product_details/screens/product_details_screen.dart';

class DealOfTheDay extends ConsumerStatefulWidget {
  const DealOfTheDay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends ConsumerState<DealOfTheDay> {
  void navigateToDetailScreen(ProductModel product) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(shoppingControllerProvider);

    return (isLoading)
        ? const Loader()
        : ref.watch(dealOfTheDayProvider(context)).when(
            data: (product) {
              return GestureDetector(
                onTap: () => navigateToDetailScreen(product!),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$${product!.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        '${product!.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return ErrorText(
                error: error.toString(),
              );
            },
            loading: () {
              return const Loader();
            },
          );
  }
}
