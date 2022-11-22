import 'package:flutter/material.dart';
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
  List<String> tasks = [];
  String groupName = '';
  String userName = '';

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _getUsers(idGroup) async {
    var ret = await GroupServices().getInformation(idGroup);

    users = ret.data.comunUsers.cast<String>();
    groupName = ret.data.nomeGrupo;
  }

  Future<bool> _getInformation(idGroup) async {
    await _getUsers(idGroup);
    await _getTasks(idGroup);

    return true;
  }

  Future<void> _getTasks(idGroup) async {
    var ret = await TaskServices().getTasks(idGroup);

    if (ret.data != '') {
      users = ret.data.comunUsers.cast<String>();
      groupName = ret.data.nomeGrupo;
    }
  }

  void _deleteUser(user, idGroup) {
    GroupServices().deleteUser(
      user,
      idGroup,
    );
    setState(() {});
  }

  void _insertUser(user, idGroup) {
    GroupServices().insertUser(
      user,
      idGroup,
    );
  }

  void save() {
    _insertUser(controller.text, widget.idGroup);
    Navigator.of(context).pop();
    setState(() {});
  }

  void close() {
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
                                _deleteUser(users[indexUser], widget.idGroup);
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
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                            controller: controller,
                          ),
                          actions: [
                            TextButton(
                              onPressed: close,
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: save,
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
                    tasks.length,
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
                        DataCell(Text(tasks[indexTask])),
                        DataCell(
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _deleteUser(users[indexTask], widget.idGroup);
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
