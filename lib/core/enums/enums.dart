enum QuestionType {
  numerical,
  multichoice,
}

enum QuestionName {
  periodIssue('periodIssue'),
  pmsTime('pmsTime'),
  periodDay('periodDay'),
  avgPeriodTime('avgPeriodTime');

  final String val;
  const QuestionName(this.val);
}
