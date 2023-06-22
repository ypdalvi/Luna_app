import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/common/loader.dart';
import 'package:luna/features/admin/controller/admin_controller.dart';

class CustomButton extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    required this.text,
    required this.onTap,
    this.color,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends ConsumerState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(adminControllerProvider);
    return (isLoading)
        ? const Loader()
        : ElevatedButton(
            onPressed: widget.onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: widget.color,
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.color == null ? Colors.white : Colors.black,
              ),
            ),
          );
  }
}
