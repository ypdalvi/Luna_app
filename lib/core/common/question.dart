import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/core/enums/enums.dart';

class Question {
  final String question;
  final List<String>? answers;
  final String name;
  final QuestionType type;
  final int? lessThan;
  final int? greaterThan;

  Question(
      {required this.question,
      this.answers,
      required this.name,
      required this.type,
      this.lessThan,
      this.greaterThan});
}

final questionListProvider =
    StateProvider<List<Question>>(((ref) => _questionList));

List<Question> _questionList = [
  Question(
    question: "Select any period problem if you have any",
    answers: ["PCOD", 'PCOS', 'None'],
    name: QuestionName.periodIssue.val,
    type: QuestionType.multichoice,
  ),
  Question(
    question: "Do you experience PMSing before, during, or after your period?",
    answers: ["before", 'during', 'after'],
    name: QuestionName.pmsTime.val,
    type: QuestionType.multichoice,
  ),
  Question(
    question: "When do your periods start every month? ",
    name: QuestionName.periodDay.val,
    type: QuestionType.numerical,
    lessThan: 31,
    greaterThan: 1,
  ),
  Question(
    question: "How long do your period last on average? ",
    name: QuestionName.avgPeriodTime.val,
    type: QuestionType.numerical,
    lessThan: 31,
    greaterThan: 1,
  ),
];
