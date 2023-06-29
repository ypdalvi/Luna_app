import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/theme/pallete.dart';
import '../../../core/constants/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

final pageProvider = StateProvider<int>((ref) => 0);

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void onPageChanged(int page) {
    ref.read(pageProvider.notifier).update((state) => page);
  }

  @override
  Widget build(BuildContext context) {
    int page = ref.watch(pageProvider);

    return Scaffold(
      body: Constants.tabWidgets[page],
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Pallete.darkestObjColor,
        backgroundColor: Pallete.objColor,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(Icons.home),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(Icons.shopping_bag),
            ),
          ),
        ],
        onTap: onPageChanged,
        currentIndex: page,
      ),
    );
  }
}
