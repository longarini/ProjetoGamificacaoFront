import 'package:flutter/material.dart';
import '../components/component/login_component.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Wellcome',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            const MyLoginComponent(),
          ],
        ),
      ),
    );
  }
}
