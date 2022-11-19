import 'package:flutter/material.dart';
import 'package:front_gamific/components/nav_drawer.dart';
import 'package:front_gamific/components/task_item.dart';
import 'package:front_gamific/core/models/group_data.dart';
import 'package:front_gamific/core/models/task_data.dart';
import '../core/services/tasks/task_service.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Widget> tasks = [];
  GroupData group = const GroupData(id: '', nomeGrupo: '');

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  Future<List<Widget>> _getTasks() async {
    var retorno = await TaskServices().getTasks(group.id);

    return retorno.map((cat) {
      return TaskItem(cat);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    group = ModalRoute.of(context)!.settings.arguments as GroupData;
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Tasks.'),
        ),
        body: FutureBuilder(
          future: _getTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView(
                padding: const EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: snapshot.data ?? [],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
