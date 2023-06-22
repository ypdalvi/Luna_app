import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/common/loader.dart';
import 'package:luna/core/constants/constants.dart';
import 'package:luna/features/auth/screens/login_screen.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    // Routemaster.of(context).push('/profile/$uid');
    // Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelProvider);

    return Drawer(
      backgroundColor: Pallete.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(Constants.avatarDefault),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              user!.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Column(
              children: [
                ListTile(
                  title: const Text(
                    'My Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  onTap: () => navigateToUserProfile(context, user.uid),
                ),
                ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Pallete.redColor,
                  ),
                  onTap: () => logOut(ref, context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
