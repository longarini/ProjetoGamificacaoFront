import 'package:flutter/material.dart';
import 'package:front_gamific/core/services/groups/group_service.dart';

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
  String groupName = '';

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _getUsers(idGroup) async {
    var ret = await GroupServices().getInformation(idGroup);

    users = ret.data.comunUsers.cast<String>();
    groupName = ret.data.nomeGrupo;

    return true;
  }

  void _deleteUser(user, idGroup) {
    GroupServices().deleteUser(
      user,
      idGroup,
    );
    setState(() {});
  }

  void _createUser(user, idGroup) {
    GroupServices().deleteUser(
      user,
      idGroup,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUsers(widget.idGroup),
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
                    (int index) => DataRow(
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
                        if (index.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(Text(users[index])),
                        DataCell(
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _deleteUser(users[index], widget.idGroup);
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
                      openAddUserDialog();
                    },
                  ),
                ),
              )
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

  Future openAddUserDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Nome do Usuario'),
            content: const TextField(
              decoration:
                  InputDecoration(hintText: 'Entre com o nome do usuário'),
            ),
            actions: [
              TextButton(
                onPressed: () => () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => () {},
                child: const Text('Salvar'),
              )
            ],
          ));
}
