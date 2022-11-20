import 'package:flutter/material.dart';
import '../../core/services/auth/auth_service_cloud.dart';
import '../../utils/app_routes.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  void logout(context) {
    AuthCloudService().logout();
    Navigator.of(context).pushNamed(
      AppRoutes.HOME,
    );
  }

  void home(context) {
    Navigator.of(context).pushNamed(
      AppRoutes.HOME,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/task.jpg'))),
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Home'),
            onTap: () => home(context),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
