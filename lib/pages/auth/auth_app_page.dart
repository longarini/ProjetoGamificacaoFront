import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:front_gamific/pages/auth/auth_page.dart';

import '../groups/admin_groups_page.dart';

class AuthAppPage extends StatefulWidget {
  const AuthAppPage({super.key});

  @override
  State<AuthAppPage> createState() => _AuthAppPageState();
}

class _AuthAppPageState extends State<AuthAppPage> {
  bool logged = false;

  @override
  void initState() {
    super.initState();
    _getLogged();
  }

  Future<bool> _getLogged() async {
    var result = await SessionManager().get("id");

    if (result != null) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return const AdminGroupsPage();
            } else {
              return const AuthPage();
            }
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
