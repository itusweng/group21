class Classes {
  Classes({required this.resultId,
    required this.studentId,
    required this.assessId,
    required this.date,
    required this.totalReadingTime,
    required this.numOfWordsReadPM,
    required this.numOfWordsReadFM,
    required this.numOfCorrectWordsReadPM,
    required this.numOfIncorrectWords});

  final String resultId;
  final String studentId;
  final String assessId;
  final String totalReadingTime;
  final String numOfWordsReadPM;
  final String numOfWordsReadFM;
  final String numOfCorrectWordsReadPM;
  final String numOfIncorrectWords;
  final DateTime date;
}