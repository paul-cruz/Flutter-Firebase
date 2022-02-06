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

  Future<void> get(String owner) async {
    print("Executing get");
    tasks
        .where('owner', isEqualTo: owner)
        .orderBy('lastModification')
        .get()
        .then((QuerySnapshot querySnapshot) {
      tasksList.value = [];
      tasksList.addAll(querySnapshot.docs.map((e) => Task.fromMap(e)).toList());
      print(tasksList);
    }).catchError((error) => print("Failed to get tasks: $error"));
  }
}
