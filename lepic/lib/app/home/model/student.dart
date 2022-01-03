class Students{
  Students({
    required this.studentName,
    required this.studentLastname,
    required this.studentClass,
  });
  final String studentName;
  final String studentClass;
  final String studentLastname;


  factory Students.fromMap(Map<String, dynamic> data) {
    final String studentName = data['studentName'];
    final String studentClass = data['studentClass'];
    final String studentLastname = data['studentLastname'];
    return Students(
        studentName: studentName,
        studentClass: studentClass,
        studentLastname: studentLastname,
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'studentName': studentName,
      'studentClass': studentClass,
      'studentLastname': studentLastname,
    };
  }
}