import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_gamific/core/services/groups/group_service.dart';

import '../../core/services/tasks/task_service.dart';

class DataTableComunUsers extends StatefulWidget {
  final String idGroup;
  const DataTableComunUsers({
    super.key,
    required this.idGroup,
  });

  @override
  State<DataTableComunUsers> createState() => _DataTableComunUsersState();
}

class _DataTableComunUsersState extends State<DataTableComunUsers> {
  List<String> users = [];
  List<String> idUsers = [];
  List<String> tasksName = [];
  List<String> tasksId = [];
  String groupName = '';
  String userName = '';

  TextEditingController controllerNameUser = TextEditingController();
  TextEditingController controllerTaskName = TextEditingController();
  TextEditingController controllerTaskDescription = TextEditingController();
  TextEditingController controllerTaskPoints = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerNameUser.dispose();
    controllerTaskDescription.dispose();
    controllerTaskName.dispose();
    controllerTaskPoints.dispose();
    super.dispose();
  }

  Future<void> _getUsers(idGroup) async {
    var ret = await GroupServices().getInformation(idGroup);
    if (ret.data.nameUsers != null) {
      users = ret.data.nameUsers.cast<String>();
      idUsers = ret.data.comunUsers.cast<String>();
    } else {
      users = [];
      idUsers = [];
    }
    groupName = ret.data.nomeGrupo;
  }

  Future<bool> _getInformation(idGroup) async {
    await _getUsers(idGroup);
    await _getTasks(idGroup);

    return true;
  }

  Future<void> _getTasks(idGroup) async {
    tasksName = [];
    tasksId = [];
    var ret = await TaskServices().getTasks(idGroup);

    if (ret.data != '') {
      ret.data.forEach((element) {
        tasksName.add(element.nomeTask);
        tasksId.add(element.id);
      });
    }
  }

  void _deleteUser(idUser, user, idGroup) async {
    var ret = await GroupServices().deleteUser(
      idUser,
      user,
      idGroup,
    );
    setState(() {});
  }

  void _insertUser(user, idGroup) async {
    var ret = await GroupServices().insertUser(
      user,
      idGroup,
    );

    setState(() {});
  }

  void _insertTask(idGroup, name, descricao, pontos) async {
    var ret = await TaskServices().insertTask(idGroup, name, descricao, pontos);
  }

  void _deleteTask(idTask) async {
    var ret = await TaskServices().deleteTask(idTask);
    setState(() {});
  }

  void saveUser() {
    _insertUser(controllerNameUser.text, widget.idGroup);
    controllerNameUser.text = '';
    Navigator.of(context).pop();

    setState(() {});
  }

  void saveTask() {
    _insertTask(widget.idGroup, controllerTaskName.text,
        controllerTaskDescription.text, controllerTaskPoints.text);
    controllerTaskName.text = '';
    controllerTaskDescription.text = '';
    controllerTaskPoints.text = '';
    Navigator.of(context).pop();
    setState(() {});
  }

  void closeTask() {
    controllerTaskName.text = '';
    controllerTaskDescription.text = '';
    controllerTaskPoints.text = '';
    Navigator.of(context).pop();
  }

  void closeUser() {
    controllerNameUser.text = '';
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInformation(widget.idGroup),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    groupName,
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
                    'Usuários',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 0, 104, 189),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Nome',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Deletar Usuario',
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    users.length,
                    (int indexUser) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (indexUser.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(Text(users[indexUser])),
                        DataCell(
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _deleteUser(idUsers[indexUser],
                                    users[indexUser], widget.idGroup);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Add Usuário'),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Nome do Usuario'),
                          content: TextField(
                            autofocus: true,
                            decoration: const InputDecoration(
                                hintText: 'Entre com o nome do usuário'),
                            controller: controllerNameUser,
                          ),
                          actions: [
                            TextButton(
                              onPressed: closeUser,
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: saveUser,
                              child: const Text('Salvar'),
                            )
                          ],
                        ),
                      );
                      ;
                    },
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
                    'Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 0, 104, 189),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Nome',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Deletar Task',
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    tasksName.length,
                    (int indexTask) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (indexTask.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(Text(tasksName[indexTask])),
                        DataCell(
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _deleteTask(tasksId[indexTask]);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Add Task'),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Nome da Task'),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: TextField(
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Entre com o nome da Task'),
                                  controller: controllerTaskName,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      hintText: 'Entre com o nome da Task'),
                                  controller: controllerTaskDescription,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      hintText: 'Pontos da Task'),
                                  controller: controllerTaskPoints,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: closeTask,
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: saveTask,
                              child: const Text('Salvar'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
