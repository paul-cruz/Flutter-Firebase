import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/app_user.dart';

class Task {
  final appUser = Get.find<AppUser>();
  late String text;
  late DateTime createdDate;
  late DateTime lastModification;
  late String owner;

  Task(String t) {
    text = t;
    createdDate = DateTime.now();
    lastModification = DateTime.now();
    owner = appUser.uid.value;
  }

  Task.fromMap(QueryDocumentSnapshot m)
      : text = m['text'],
        createdDate = (m['createdDate'] as Timestamp).toDate(),
        lastModification = (m['lastModification'] as Timestamp).toDate(),
        owner = m['owner'];
}
