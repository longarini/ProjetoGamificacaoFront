import 'package:front_gamific/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                TextFormField(
                  key: const ValueKey('user'),
                  initialValue: _formData.user,
                  onChanged: (user) => _formData.user = user,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                  validator: (User) {
                    final user = User ?? '';
                    if (user.trim().length < 5) {
                      return 'Usuário deve ter no mínimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('pwd'),
                initialValue: _formData.pwd,
                onChanged: (pwd) => _formData.pwd = pwd,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (Pwd) {
                  final pwd = Pwd ?? '';
                  if (pwd.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              if (!_formData.isLogin)
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                validator: (email) {
                },
              ),
              if (!_formData.isLogin)
              TextFormField(
                key: const ValueKey('nome'),
                initialValue: _formData.nome,
                onChanged: (nome) => _formData.nome = nome,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              if (!_formData.isLogin)
              TextFormField(
                key: const ValueKey('sobrenome'),
                initialValue: _formData.sobrenome,
                onChanged: (sobrenome) => _formData.sobrenome = sobrenome,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
