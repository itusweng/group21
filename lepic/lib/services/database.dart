
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/services/api_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'firestore_service.dart';
abstract class Database{
  Future<void> addClass(Classes classes);
  void readClass();
  Stream<List<Classes>> classesStream();
}
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
class FirestoreDatabase implements Database{
  FirestoreDatabase ({required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> addClass(Classes classes) => _setData(
    path: ApiPath.classes(uid,'class_123'),
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
  Stream<List<Classes>> classesStream() => FirestoreService.instance.collectionStream(
    path: ApiPath.allClasses(uid),
    builder: (data) => Classes.fromMap(data),
  );

  Future<void> _setData({required String path, required Map<String, dynamic> data}) async {
    final documentRef = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await documentRef.set(data);
  }
}