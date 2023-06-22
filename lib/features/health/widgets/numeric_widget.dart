import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/pallete.dart';

class NumericWidget extends StatelessWidget {
  const NumericWidget({
    Key? key,
    required this.ref,
    required this.textController,
  }) : super(key: key);

  final WidgetRef ref;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                    ),
                    BoxShadow(
                      offset: const Offset(10, 10),
                      color: Pallete.lightGreyColor,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                      controller: textController,
                      decoration: InputDecoration(
                        focusedBorder:InputBorder.none ,
                        labelText: "Enter here",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Pallete.darkestObjColor),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
