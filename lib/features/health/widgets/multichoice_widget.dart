import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/question.dart';
import '../../../theme/pallete.dart';
import '../screens/health_card_screen.dart';

class MultiChoiceWidget extends StatelessWidget {
  const MultiChoiceWidget({
    Key? key,
    required this.questionList,
    required this.currentIndex,
    required this.radioval,
    required this.ref,
  }) : super(key: key);

  final List<Question> questionList;
  final int currentIndex;
  final String? radioval;
  final WidgetRef ref;

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
                    ...questionList[currentIndex].answers!.map(
                          (e) => RadioListTile<String>(
                            groupValue: radioval,
                            activeColor: Colors.red,
                            title: Text(
                              e,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            onChanged: (val) {
                              ref
                                  .watch(radioProvider.notifier)
                                  .update((state) => val);
                            },
                            value: e,
                          ),
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
