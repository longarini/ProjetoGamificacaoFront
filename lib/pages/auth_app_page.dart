import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/auth_signup_data.dart';
import 'package:front_gamific/core/services/auth/auth_service_cloud.dart';
import 'package:front_gamific/pages/auth_page.dart';
import 'package:front_gamific/pages/group_page.dart';
import 'package:front_gamific/pages/loading_page.dart';
import 'package:front_gamific/pages/main_page.dart';

class AuthAppPage extends StatelessWidget {
  const AuthAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserSignup?>(
        stream: AuthCloudService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ?  const GroupsPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
