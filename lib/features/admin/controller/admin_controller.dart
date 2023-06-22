import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/admin/repository/admin_repository.dart';
import 'package:luna/models/product_model.dart';
import 'package:uuid/uuid.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';

final adminControllerProvider =
    StateNotifierProvider<AdminController, bool>((ref) {
  final adminRepository = ref.watch(adminRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return AdminController(
    adminRepository: adminRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

class AdminController extends StateNotifier<bool> {
  final AdminRepository _adminRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  AdminController({
    required AdminRepository adminRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _adminRepository = adminRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> files,
  }) async {
    state = true;
    String pid = const Uuid().v1();
    List<String> images = [];

    try {
      int i = 1;
      for (File file in files) {
        final image = await _storageRepository.storeFile(
          path: 'products/$category/$pid',
          id: i.toString(),
          file: file,
        );
        images.add(image);
        i++;
      }

      final ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: images,
        category: category,
        price: price,
        pid: pid,
        rating: [],
      );

      await _adminRepository.addProduct(product);

      state = false;
      print("success");
      if (context.mounted) {
        showSnackBar(context, "Success");
      }
    } catch (e) {
      state = false;
      showSnackBar(context, e.toString());
    }
  }
}
