import 'package:flutter/material.dart';
import 'package:front_gamific/components/nav_drawer.dart';
import '../core/models/group_data.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final group = ModalRoute.of(context)!.settings.arguments as GroupData;

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Text(group.nomeGrupo),
      ),
      body: Center(
        child: Text('Receitas por Categoria ${group.id}'),
      ),
    );
  }
}
