import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/task.dart';
import 'package:get/get.dart';

import 'app_user.dart';

class Taskcontroller extends GetxController {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  final appUser = Get.find<AppUser>();
  var tasksList = <Task>[].obs;
  final taskTextController = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    await get(appUser.uid.value);
  }

  Future<String> add(Task t) async {
    return tasks.add({
      'text': t.text,
      'createdDate': t.createdDate,
      'lastModification': t.lastModification,
      'owner': t.owner
    }).then((value) async {
      await get(t.owner);
      return "Task Added";
    }).catchError((error) => "Failed to add task: $error");
  }

  Future<String> delete(String docId) {
    return tasks
        .doc(docId)
        .delete()
        .then((value) => "User Deleted")
        .catchError((error) => "Failed to delete user: $error");
  }

  Future<void> get(String owner) async {
    print("Executing get");
    var querySnapshot = await tasks
        .where('owner', isEqualTo: owner)
        .orderBy('lastModification')
        .get();

    tasksList.value = (querySnapshot.docs.map((e) => Task.fromMap(e)).toList());
    update(['Lista']);
    print(tasksList);
  }
}
