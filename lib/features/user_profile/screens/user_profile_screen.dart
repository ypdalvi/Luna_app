// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:luna/core/constants/constants.dart';
// import 'package:luna/theme/pallete.dart';
// import 'package:routemaster/routemaster.dart';
// import '../../../core/common/error_text.dart';
// import '../../../core/common/loader.dart';
// import '../../auth/controller/auth_controller.dart';
// import '../../health/controller/health_controller.dart';

// class UserProfileScreen extends ConsumerWidget {
//   final String uid;
//   const UserProfileScreen({
//     super.key,
//     required this.uid,
//   });

//   void navigateToEditUser(BuildContext context) {
//     Routemaster.of(context).push('/edit-profile/$uid');
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final healthCard = ref.watch(healthModelProvider)!;
//     return Scaffold(
//       body: ref.watch(userProvider).when(
//             data: (user) => DecoratedBox(
//               decoration: BoxDecoration(
//                 color: Pallete.backgroundColor,
//               ),
//               child: NestedScrollView(
//                 headerSliverBuilder: (context, innerBoxIsScrolled) {
//                   return [
//                     SliverAppBar(
//                       expandedHeight: 250,
//                       floating: true,
//                       snap: true,
//                       flexibleSpace: Stack(
//                         children: [
//                           Positioned.fill(
//                             child: Image.network(
//                               Constants.bannerDefault,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.bottomLeft,
//                             padding:
//                                 const EdgeInsets.all(20).copyWith(bottom: 70),
//                             child: const CircleAvatar(
//                               backgroundImage:
//                                   NetworkImage(Constants.avatarDefault),
//                               radius: 45,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.bottomLeft,
//                             padding: const EdgeInsets.all(20),
//                             child: OutlinedButton(
//                               onPressed: () => navigateToEditUser(context),
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                               ),
//                               child: const Text('Edit Profile'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.all(16),
//                       sliver: SliverList(
//                         delegate: SliverChildListDelegate(
//                           [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   user.name,
//                                   style: const TextStyle(
//                                     fontSize: 19,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             const Divider(thickness: 2),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ];
//                 },
//                 body: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Pallete.backgroundColor,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             const Text("period Date : "),
//                             const Spacer(),
//                             Text(
//                               healthCard.periodDate.toIso8601String(),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//             ),
//             error: (error, stackTrace) => ErrorText(error: error.toString()),
//             loading: () => const Loader(),
//           ),
//     );
//   }
// }
