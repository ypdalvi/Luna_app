import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/shopping/controller/shopping_controller.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';


class DealOfTheDay extends ConsumerStatefulWidget {
  const DealOfTheDay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends ConsumerState<DealOfTheDay> {

  // void navigateToDetailScreen() {
  //   Navigator.pushNamed(
  //     context,
  //     ProductDetailScreen.routeName,
  //     arguments: product,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(shoppingControllerProvider);

    return (isLoading)
        ? const Loader()
        : ref.watch(dealOfTheDayProvider).when(
            data: (product) {
              return GestureDetector(
                // onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Rivaan',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product.images
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
