import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/task_data.dart';

class TaskItem extends StatelessWidget {
  final TaskData task;

  const TaskItem(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => () {},
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 225, 255, 0).withOpacity(0.5),
              const Color.fromARGB(255, 225, 255, 0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          task.nomeTask,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
