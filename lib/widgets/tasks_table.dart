import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/controllers/task_controller.dart';
import 'package:get/get.dart';

class TasksTable extends StatelessWidget {
  final taskcont = Get.find<Taskcontroller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Obx(() => ListView.builder(
            itemBuilder: (context, index) =>
                Text(taskcont.tasksList[index].text),
            itemCount: taskcont.tasksList.length,
          )),
    );
  }
}
