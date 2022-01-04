class Students{
  Students({
    // TODO add class id
    required this.studentFirstName,
    required this.studentLastName,
    required this.studentClass,
  });
  final String studentFirstName;
  final String studentLastName;
  final String studentClass;



  factory Students.fromMap(Map<String, dynamic> data) {
    final String studentFirstName = data['studentFirstName'];
    final String studentLastName = data['studentLastName'];
    final String studentClass = data['studentClass'];
    return Students(
      studentFirstName: studentFirstName,
      studentLastName: studentLastName,
        studentClass: studentClass,
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'studentFirstName': studentFirstName,
      'studentLastname': studentLastName,
      'studentClass': studentClass,

    };
  }
}