import 'package:flutter/material.dart';
import 'package:front_gamific/components/auth_form.dart';
import 'package:front_gamific/core/models/auth_form_data.dart';
import 'package:front_gamific/core/services/auth/auth_service_cloud.dart';
import 'package:front_gamific/pages/auth_app_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        String ret = await AuthCloudService().login(
          formData.user,
          formData.pwd,
        );

        if (ret != '') {
          _showDialog(ret, 'Falha de Autenticação');
        }
      } else {
        String ret = await AuthCloudService().signup(
          formData.user,
          formData.pwd,
          formData.email,
          formData.nome,
          formData.sobrenome,
        );
        if (ret == '') {
          await _showDialog(
            'Usuario criado com sucesso',
            'Criação de Usuário',
          );
          resetPage();
        } else {
          _showDialog(ret, 'Falha na Criação de Usuário');
        }
      }
    } catch (error) {
      //Implantar Tratamento.
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void resetPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const AuthAppPage()));
  }

  Future _showDialog(descricao, titulo) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(titulo),
          content: Text(descricao),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
            Center(
              child: SingleChildScrollView(
                child: AuthForm(onSubmit: _handleSubmit),
              ),
            ),
            if (_isLoading)
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
