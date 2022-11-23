import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/group_data.dart';
import 'package:front_gamific/core/models/task/retorno_task.dart';
import 'package:front_gamific/core/services/tasks/task_service.dart';

import '../../pages/tasks/task_admin_page.dart';

class TaskItem extends StatelessWidget {
  final RetornoTask task;
  final GroupData group;

  const TaskItem(this.group, this.task, {Key? key}) : super(key: key);

  void _selectTask(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AdminTaskPage(
                  idTask: task.id,
                  group: group,
                )));
  }

  Future<bool> _getEndTask() async {
    var ret = await TaskServices().consultEndTask(task.id);

    return ret.data;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTask(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: FutureBuilder(
        future: _getEndTask(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!) {
              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 0, 162, 255).withOpacity(0.5),
                      const Color.fromARGB(255, 0, 162, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  task.nomeTask,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 255, 153, 0).withOpacity(0.5),
                      const Color.fromARGB(255, 255, 153, 0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  task.nomeTask,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
