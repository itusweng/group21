
class ApiPath{
  static String classes(String uid,
  String classId) => 'users/$uid/classes/$classId';
  static String allClasses(String uid) =>'users/$uid/classes';

}