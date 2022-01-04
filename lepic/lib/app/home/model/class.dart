class Classes {
  Classes(
      {required this.classLevel,
      required this.className,
      required this.creatorName,
      required this.studentList});

  final String className;
  final String classLevel;
  final String creatorName;
  final List<dynamic>? studentList;

  factory Classes.fromMap(Map<String, dynamic> data) {
    final String className = data['className'];
    final String classLevel = data['classLevel'];
    final String creatorName = data['creatorName'];
    final List<dynamic>? studentList = data['studentList'];
    return Classes(
        className: className,
        classLevel: classLevel,
        creatorName: creatorName,
        studentList: studentList);
  }

  Map<String, dynamic> toMap() {
    return {
      'classLevel': classLevel,
      'className': className,
      'creatorName': creatorName,
      'studentList': studentList
    };
  }
}
