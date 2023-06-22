import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/utils.dart';
import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';

final userModelProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider<UserModel?>((ref) {
  final authController = ref.read(authControllerProvider.notifier);
  ref.watch(authStateChangeProvider);
  return authController.getUserData();
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository authRepository;
  final Ref ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  }) : super(false);

  Stream<User?> get authStateChange => authRepository.authStateChange;

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    ref.read(userModelProvider.notifier).update((state) => user);
    return user;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      state = true;
      final user = await authRepository.signInWithGoogle();
      state = false;
      return user;
    } catch (e) {
      state = false;
      log(e.toString());
    }
  }

  void updateUserData(UserModel userModel, BuildContext context) {
    authRepository.updateUserData(context, userModel);
  }

  void logout() async {
    state = true;
    await authRepository.logOut();
    state = false;
  }
  // void verifyOTP(BuildContext context, String verificationId, String userOTP) {
  //   authRepository.verifyOTP(
  //     context: context,
  //     verificationId: verificationId,
  //     userOTP: userOTP,
  //   );
  // }

  // void saveUserDataToFirebase(
  //     BuildContext context, String name, File? profilePic) {
  //   authRepository.saveUserDataToFirebase(
  //     name: name,
  //     profilePic: profilePic,
  //     ref: ref,
  //     context: context,
  //   );
  // }

  // Stream<UserModel> userDataById(String userId) {
  //   return authRepository.userData(userId);
  // }

  // void setUserState(bool isOnline) {
  //   authRepository.setUserState(isOnline);
  // }
}
