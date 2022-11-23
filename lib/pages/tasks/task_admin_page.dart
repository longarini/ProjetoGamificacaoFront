import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/group_data.dart';
import 'package:front_gamific/core/services/tasks/task_service.dart';
import 'package:front_gamific/pages/tasks/task_page.dart';
import '../../components/comun/nav_drawer.dart';
import '../../core/models/task/retorno_task.dart';
import '../../utils/app_routes.dart';

class AdminTaskPage extends StatefulWidget {
  final String idTask;
  final GroupData group;
  const AdminTaskPage({super.key, required this.idTask, required this.group});

  @override
  State<AdminTaskPage> createState() => _AdminTaskPageState();
}

class _AdminTaskPageState extends State<AdminTaskPage> {
  Future<RetornoTask> _getTaskInformation(idTask) async {
    var ret = await TaskServices().getTasksById(idTask);

    return ret.data;
  }

  void _finalizarTask() {
    TaskServices().endTask(widget.idTask);

    Navigator.of(context).pushNamed(
      AppRoutes.TASKS,
      arguments: widget.group,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Detalhes da Task'),
      ),
      body: FutureBuilder(
        future: _getTaskInformation(widget.idTask),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            snapshot.data!.nomeTask,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 104, 189),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.blue,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Descrição',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 104, 189),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            snapshot.data!.descricao,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 104, 189),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Pontos: ${snapshot.data!.pontos}',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 104, 189),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _finalizarTask,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text('Finalizar Task'),
                        ),
                      ),
                    ],
                  ),
                ));
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
