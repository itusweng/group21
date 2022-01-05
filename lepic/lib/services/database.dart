
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/app/home/model/student.dart';
import 'package:exp/app/home/model/user.dart';
import 'package:exp/services/api_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'firestore_service.dart';
abstract class Database{
  Future<void> addClass(Classes classes);
  void readClass();
  Stream<List<Classes>> classesStream();
  Future<void> createUser(Users user);
  Future<void> createClass(Classes classes);
}
// in order to create uniqe document id
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
class FirestoreDatabase implements Database{
  FirestoreDatabase ({required this.uid}) : assert(uid != null);
  final String uid;
  final _FsService = FirestoreService.instance;

  /*
  Future<void> addStudent(Students students) => _FsService.setData(
    path: ApiPath.students(documentIdFromCurrentDate()),
    data: students.toMap(),
  );
  Future<void> addStudentToClass(Students students) => _FsService.setData(
    path: ApiPath.studentOfClass(uid, documentIdFromCurrentDate(),documentIdFromCurrentDate()),
    data: students.toMap(),
  );
  Stream<List<Students>> studentsStream() => _FsService.collectionStream(
    path: ApiPath.studentOfClass(uid, classId),
    builder: (data) => Students.fromMap(data),
  );
  */
  Future<void> createUser(Users user) async {
    try {
      final reference = FirebaseFirestore.instance.collection("users");
      await reference.add({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'userType':user.userType,
        'userId': uid,
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> createClass(Classes classes) async {
    try {
      final reference = FirebaseFirestore.instance.doc(ApiPath.classes(uid,documentIdFromCurrentDate()));
      await reference.set({
        'className': classes.className,
        'classLevel': classes.classLevel,
        'classId': classes.Id,
        'creatorName':classes.creatorName,
        'studentList': classes.studentList,
      });
    } catch (e) {
      print(e);
    }
  }


  Future<void> addClass(Classes classes) => _FsService.setData(
    path: ApiPath.classes(uid,documentIdFromCurrentDate()),
    data:classes.toMap(),
  );
  void readClass(){
    final path = ApiPath.allClasses(uid);
    final ref = FirebaseFirestore.instance.collection(path);
    final snapshots = ref.snapshots();
    snapshots.listen((snapshot) {
      snapshot.docs.forEach((snapshot) =>
        print(snapshot.data()));
    });
  }
  Stream<List<Classes>> classesStream() => _FsService.collectionStream(
    path: ApiPath.allClasses(uid),
    builder: (data, documentId) => Classes.fromMap(data, documentId),
  );

  Future<void> _setData({required String path, required Map<String, dynamic> data}) async {
    final documentRef = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await documentRef.set(data);
  }
}