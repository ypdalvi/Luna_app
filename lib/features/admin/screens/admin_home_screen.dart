import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/admin/controller/admin_controller.dart';
import 'package:luna/theme/pallete.dart';
import '../../../core/common/custom_button.dart';
import '../../../core/common/custom_textfield.dart';
import '../../../core/utils.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminHomeState();
}

final imageListProvider = StateProvider<List<File>>((ref) => []);

final categoryProvider = StateProvider<String?>((ref) => 'Period Products');

class _AdminHomeState extends ConsumerState<AdminHome> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Period Products',
    'Pain Relief',
    'Intimate Hygiene',
    'Custom Kits',
  ];

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void sellProduct(List<File> images) {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();

      final name = productNameController.text;
      final description = descriptionController.text;
      final price = double.parse(priceController.text);
      final quantity = double.parse(quantityController.text);
      final category = ref.read(categoryProvider);
      
      ref.read(adminControllerProvider.notifier).addProduct(
          context: context,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category!,
          files: images);

      // reset();
    }
  }

  void reset() {
    productNameController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    quantityController.text = "";
    ref.read(categoryProvider.notifier).update((state) => 'Period Products');
    ref.read(imageListProvider.notifier).update((state) => []);
  }

  void selectImages() async {
    var res = await pickImages(context);
    ref.watch(imageListProvider.notifier).update((state) => res);
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(imageListProvider);
    final category = ref.watch(categoryProvider);

    return RefreshIndicator(
      onRefresh: () async {
        reset();
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            // flexibleSpace: Container(
            //   decoration: const BoxDecoration(
            //     gradient: GlobalVariables.appBarGradient,
            //   ),
            // ),
            title: const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    isNumeric: false,
                    controller: productNameController,
                    hintText: 'Product Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isNumeric: false,
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 7,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isNumeric: true,
                    controller: priceController,
                    hintText: 'Price',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isNumeric: true,
                    controller: quantityController,
                    hintText: 'Quantity',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      dropdownColor: Pallete.objColor,
                      style: const TextStyle(color: Colors.black),
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(backgroundColor: Pallete.objColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        ref
                            .read(categoryProvider.notifier)
                            .update((state) => newVal);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    color: Pallete.darkestObjColor,
                    text: 'Sell',
                    onTap: () => sellProduct(images),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
