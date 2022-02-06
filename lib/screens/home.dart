import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/controllers/app_user.dart';
import 'package:flutter_firebase_app/controllers/task_controller.dart';
import 'package:flutter_firebase_app/services/authentication.dart';
import 'package:flutter_firebase_app/widgets/custom_snack_bar.dart';
import 'package:get/get.dart';

import '../models/task.dart';
import '../widgets/tasks_table.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final appUser = Get.find<AppUser>();
    final taskController = Get.put(Taskcontroller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.network(appUser.photoUrl.value),
            ),
            Text(
              'Name: ${appUser.name.value}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Email: ${appUser.email.value}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Agregar tarea'),
                  content: TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Ingresa la tarea',
                    ),
                    controller: taskController.taskTextController,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final text = taskController.taskTextController.text;
                        if (text == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Necesita agregar un texto'),
                              );
                            },
                          );
                          return;
                        }
                        final t = Task(text);
                        final res = await Taskcontroller().add(t);
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.customSnackBar(alertContent: res));
                      },
                      child: const Text('Agregar'),
                    ),
                  ],
                ),
              ),
              child: const Text(
                "Agregar tarea",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            TasksTable(),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Authentication.signOut(context: context);
        },
        icon: const Icon(
          Icons.logout_outlined,
          color: Colors.blue,
        ),
      ),
    );
  }
}
