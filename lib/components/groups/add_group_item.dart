import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';

class AddGroupItem extends StatelessWidget {
  const AddGroupItem({Key? key}) : super(key: key);

  void _selectAddGroup(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.ADD_GROUP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectAddGroup(context),
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
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}
