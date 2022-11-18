import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:front_gamific/core/models/auth_signup_data.dart';
import 'package:front_gamific/core/services/auth/auth_service_cloud.dart';
import 'package:front_gamific/pages/auth_page.dart';
import 'package:front_gamific/pages/group_page.dart';
import 'package:front_gamific/pages/loading_page.dart';
import 'package:front_gamific/pages/main_page.dart';

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



  Future<void> _getLogged() async {
    var result = await SessionManager().get("id"); 

    if(result != null){
      logged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserSignup?>(
        stream: AuthCloudService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return logged ?  const GroupsPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
