import 'package:flutter/material.dart';
import 'package:front_gamific/components/groups/add_group_item.dart';
import 'package:front_gamific/components/comun/nav_drawer.dart';
import 'package:front_gamific/components/groups/group_item_comun.dart';
import '../../core/services/groups/group_service.dart';

class UserGroupsPage extends StatefulWidget {
  const UserGroupsPage({super.key});

  @override
  State<UserGroupsPage> createState() => _UserGroupsPageState();
}

class _UserGroupsPageState extends State<UserGroupsPage> {
  List<Widget> groups = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Widget>> _getGroups() async {
    groups = [];
    var retorno = await GroupServices().getComunGroups();

    if (retorno.status == 200) {
      if (retorno.data != null) {
        groups.addAll(retorno.data.map<Widget>((cat) {
          return GroupItemComun(cat);
        }).toList());
      }
    }
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
