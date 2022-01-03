
class ApiPath{
  static String classes(String uid,
  String classId) => 'users/$uid/classes/$classId';
  static String allClasses(String uid) =>'users/$uid/classes';
  static String studentOfClass(String uid, String classId) => 'users/$uid/classes/$classId/students';
  static String students(String studentId) => 'students/$studentId';
}