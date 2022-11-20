import 'package:flutter/material.dart';
import 'package:front_gamific/components/groups/add_group_item.dart';
import 'package:front_gamific/components/comun/nav_drawer.dart';
import '../../components/groups/group_item.dart';
import '../../core/services/groups/group_service.dart';

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
  }

  Future<List<Widget>> _getGroups() async {
    groups = [];
    var retorno = await GroupServices().getGroups();

    if (retorno.status == 200) {
      if (retorno.data != null) {
        groups.addAll(retorno.data.map<Widget>((cat) {
          return GroupItem(cat);
        }).toList());
      }
    }
    groups.add(const AddGroupItem());

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Groups.'),
      ),
      body: FutureBuilder(
        future: _getGroups(),
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
      ),
    );
  }
}
