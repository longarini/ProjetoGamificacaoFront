import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/group_data.dart';
import '../../pages/groups/admin_group_page.dart';
import '../../utils/app_routes.dart';

class GroupItem extends StatelessWidget {
  final GroupData group;

  const GroupItem(this.group, {Key? key}) : super(key: key);

  void _selectGroup(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AdminGroupPage(
                  idGroup: group.id,
                )));

    // Navigator.of(context).pushNamed(
    //   AppRoutes.TASKS,
    //   arguments: group,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectGroup(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 0, 128, 255).withOpacity(0.5),
              const Color.fromARGB(255, 0, 128, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            group.nomeGrupo,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
