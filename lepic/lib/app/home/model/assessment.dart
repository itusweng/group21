class Assessment {
  Assessment({
    required this.assessmentName,
    required this.textList,
  });

  final String assessmentName;
  final List<dynamic>? textList;

  factory Assessment.fromMap(Map<String, dynamic> data) {
    final String assessmentName = data['assessmentName'];
    final List<dynamic>? textList = data['textList'];
    return Assessment(assessmentName: assessmentName, textList: textList);
  }
}
