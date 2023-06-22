import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/auth/controller/auth_controller.dart';

final dropDownProvider = StateProvider<bool>(((ref) => false));

class AddressBox extends ConsumerWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelProvider)!;
    final dropDown = ref.watch(dropDownProvider);

    return Container(
      height: (dropDown) ? null : 40,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Pallete.backgroundColor,
      //       Pallete.darkObjColor,
      //     ],
      //     stops: const [0.5, 1.0],
      //   ),
      // ),
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () =>
            ref.read(dropDownProvider.notifier).update((state) => !state),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: Colors.black,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Delivery to ${user.name} - ${user.address}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: (dropDown) ? null : TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 2,
              ),
              child: Icon(
                (dropDown)
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down_outlined,
                size: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
