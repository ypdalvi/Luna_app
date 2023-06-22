import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/auth/controller/auth_controller.dart';
import 'package:luna/features/health/repository/health_repository.dart';
import 'package:luna/models/health_model.dart';

final healthModelProvider =
    StateProvider<HealthModel>((ref) => HealthModel(attributes: {}));

final healthControllerProvider = StateNotifierProvider<HealthController, bool>(
  (ref) => HealthController(
    healthRepository: ref.watch(healthRepositoryProvider),
    ref: ref,
  ),
);

final getHealthModelProvider = FutureProvider.family((ref, String hid) {
  final healthController = ref.watch(healthControllerProvider.notifier);
  return healthController.getHealthCard(hid);
});

class HealthController extends StateNotifier<bool> {
  final HealthRepository _healthRepository;
  final Ref _ref;
  HealthController({
    required HealthRepository healthRepository,
    required Ref ref,
  })  : _healthRepository = healthRepository,
        _ref = ref,
        super(false);

  void updateHealthRepository(BuildContext context) {
    final healthModel = _ref.read(healthModelProvider);
    final userModel = _ref.read(userModelProvider)!;
    _healthRepository.updateHealthCard(healthModel, userModel.hid, context);
  }

  Future<HealthModel?> getHealthCard(String hid) async {
    try {
      final healthModel = await _healthRepository.getHealthCard(hid);
      _ref
          .read(healthModelProvider.notifier)
          .update((state) => healthModel ?? state);
      return healthModel;
    } catch (e) {
      rethrow;
    }
  }
}
