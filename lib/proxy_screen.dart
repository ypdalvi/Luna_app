import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/common/loader.dart';
import 'package:luna/features/admin/screens/admin_home_screen.dart';
import 'package:luna/features/auth/controller/auth_controller.dart';
import 'package:luna/features/health/screens/health_card_screen.dart';
import 'package:luna/features/home/screens/home_screen.dart';

class ProxyScreen extends ConsumerWidget {
  static const String routeName = '/proxy-screen';
  const ProxyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelProvider);

    if (user == null) {
      return const Loader();
    } else if (user.isAdmin) {
      return const AdminHome();
    } else if (user.isFilled) {
      return const HomeScreen();
    } else {
      return const HealthCardScreen();
    }
  }
}
