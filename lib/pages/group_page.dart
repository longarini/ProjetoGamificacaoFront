import 'package:flutter/material.dart';
import 'package:front_gamific/components/nav_drawer.dart';
import '../components/group_item.dart';
import '../core/services/groups/group_service.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Widget> groups = [];

  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  Future<void> _getGroups() async {
    var retorno = await GroupServices().getGroups();

    groups = retorno.map((cat) {
      return GroupItem(cat);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Tasks.'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: groups,
      ),
    );
  }
}
