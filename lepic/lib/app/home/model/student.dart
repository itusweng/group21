class Students{
  Students({
    required this.studentName,
    required this.studentClass,
  });
  final String studentName;
  final String studentClass;


  factory Students.fromMap(Map<String, dynamic> data) {
    final String studentName = data['studentName'];
    final String studentClass = data['studentClass'];
    return Students(
        studentName: studentName,
        studentClass: studentClass,
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'studentName': studentName,
      'studentClass': studentClass,
    };
  }
}