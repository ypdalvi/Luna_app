import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/common/question.dart';
import 'package:luna/core/enums/enums.dart';
import 'package:luna/core/utils.dart';
import 'package:luna/features/health/controller/health_controller.dart';
import 'package:luna/features/health/widgets/numeric_widget.dart';
import 'package:luna/features/home/screens/home_screen.dart';
import 'package:luna/theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../widgets/multichoice_widget.dart';

class HealthCardScreen extends ConsumerStatefulWidget {
  const HealthCardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _THealthCardScreenState();
}

final currentQuestionProvider = StateProvider<Question>((ref) {
  final index = ref.watch(currentIndexProvider);
  return ref.read(questionListProvider)[index];
});

final radioProvider = StateProvider<String?>((ref) => null);

final currentIndexProvider = StateProvider<int>((ref) => 0);

class _THealthCardScreenState extends ConsumerState<HealthCardScreen> {
  final inputController = TextEditingController();

  void navigateToHome(BuildContext context) {
    ref
        .read(userModelProvider.notifier)
        .update((state) => state!.copyWith(isFilled: true));
    final userModel = ref.read(userModelProvider)!;
    ref
        .read(authControllerProvider.notifier)
        .updateUserData(userModel, context);
    ref.read(healthControllerProvider.notifier).updateHealthRepository(context);
  }

  void inkWellOnTap(int e) {
    ref.read(currentIndexProvider.notifier).update((state) => e);
    final currentQuestion = ref.read(currentQuestionProvider);
    final health = ref.read(healthModelProvider);
    final name = currentQuestion.name;
    print(name);
    final type = currentQuestion.type;
    if (type == QuestionType.multichoice) {
      ref
          .read(radioProvider.notifier)
          .update((state) => health.attributes[name]);
    } else if (health.attributes[name] != null) {
      inputController.text = health.attributes[name].toString();
    } else {
      inputController.text = '';
    }
  }

  void elevatedButtonOnTap() {
    final currentQuestion = ref.read(currentQuestionProvider);
    final questionList = ref.read(questionListProvider);
    final name = currentQuestion.name;
    final type = currentQuestion.type;
    final radioval = ref.read(radioProvider);

    if (type == QuestionType.numerical) {
      int? val = int.tryParse(inputController.text);
      int lt = currentQuestion.lessThan!;
      int gt = currentQuestion.greaterThan!;

      if (val != null && val >= gt && val <= lt) {
        ref.read(healthModelProvider.notifier).update((state) {
          var stateMap = state.attributes;
          stateMap[name] = val;
          return state.copyWith(attributes: stateMap);
        });
      } else {
        showSnackBar(context, "Enter a proper value!");
        return;
      }
    } else {
      if (radioval == null) {
        showSnackBar(context, "Please select a option!");
        return;
      } else {
        ref.read(healthModelProvider.notifier).update(
          (state) {
            var stateMap = state.attributes;
            stateMap[name] = radioval;
            return state.copyWith(attributes: stateMap);
          },
        );
      }
    }

    final currentIndex = ref.read(currentIndexProvider);

    if (currentIndex == questionList.length - 1) {
      navigateToHome(context);
    } else {
      ref.read(currentIndexProvider.notifier).update((state) => state + 1);

      final nextQuestion = ref.read(currentQuestionProvider);
      final health = ref.read(healthModelProvider);
      final nextname = nextQuestion.name;
      final nexttype = nextQuestion.type;
      if (nexttype == QuestionType.multichoice) {
        ref
            .read(radioProvider.notifier)
            .update((state) => health.attributes[nextname]);
      } else if (health.attributes[nextname] != null) {
        inputController.text = health.attributes[nextname].toString();
      } else {
        inputController.text = '';
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionList = ref.read(questionListProvider);
    final radioval = ref.watch(radioProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final currentQuestion = ref.watch(currentQuestionProvider);
    List<int> listOfQuestionNumbers =
        List<int>.generate(questionList.length, (i) => i);

    Widget getWidget(QuestionType type) {
      if (type == QuestionType.multichoice) {
        return MultiChoiceWidget(
            questionList: questionList,
            currentIndex: currentIndex,
            radioval: radioval,
            ref: ref);
      } else if (type == QuestionType.numerical) {
        return NumericWidget(
          ref: ref,
          textController: inputController,
        );
      }
      return const SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Pallete.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children: const <Widget>[
            Text(
              "Tell us about yourself",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 280,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Pallete.objColor),
              ),
            ),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          ...listOfQuestionNumbers
                              .map((e) => SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: InkWell(
                                      onTap: () => inkWellOnTap(e),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentIndex == e
                                                ? Colors.white
                                                : Pallete.darkestObjColor,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                    color: currentIndex == e
                                                        ? Colors.black
                                                        : Colors.grey[200],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        currentQuestion.question,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    getWidget(currentQuestion.type),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.darkObjColor,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              elevatedButtonOnTap();
                            },
                            child: Text(
                              currentIndex == questionList.length - 1
                                  ? "Submit"
                                  : "Next",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
