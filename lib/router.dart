import 'package:flutter/material.dart';
import 'package:luna/core/common/error_text.dart';
import 'package:luna/features/admin/screens/admin_home_screen.dart';
import 'package:luna/features/home/screens/home_screen.dart';
import 'package:luna/models/product_model.dart';
import 'package:luna/proxy_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'features/shopping/screens/category_deals_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case ProxyScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ProxyScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = settings.arguments as ProductModel;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    // case UserInformationScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (context) => const UserInformationScreen(),
    //   );
    // case SelectContactsScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (context) => const SelectContactsScreen(),
    //   );
    // case MobileChatScreen.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;
    //   final name = arguments['name'];
    //   final uid = arguments['uid'];
    //   final isGroupChat = arguments['isGroupChat'];
    //   final profilePic = arguments['profilePic'];
    //   return MaterialPageRoute(
    //     builder: (context) => MobileChatScreen(
    //       name: name,
    //       uid: uid,
    //       isGroupChat: isGroupChat,
    //       profilePic: profilePic,
    //     ),
    //   );
    // case ConfirmStatusScreen.routeName:
    //   final file = settings.arguments as File;
    //   return MaterialPageRoute(
    //     builder: (context) => ConfirmStatusScreen(
    //       file: file,
    //     ),
    //   );
    // case StatusScreen.routeName:
    //   final status = settings.arguments as Status;
    //   return MaterialPageRoute(
    //     builder: (context) => StatusScreen(
    //       status: status,
    //     ),
    //   );
    // case CreateGroupScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (context) => const CreateGroupScreen(),
    //   );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
