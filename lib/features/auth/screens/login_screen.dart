import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/theme/pallete.dart';
import '../../../core/common/loader.dart';
import '../widgets/sign_in_button.dart';
import '../../../core/constants/constants.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
      ),
      body: isLoading
          ? const Loader()
          : DecoratedBox(
              decoration: BoxDecoration(color: Pallete.backgroundColor),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Dive into your health',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Constants.loginEmotePath,
                      height: 400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SignInButton(),
                ],
              ),
            ),
    );
  }
}
