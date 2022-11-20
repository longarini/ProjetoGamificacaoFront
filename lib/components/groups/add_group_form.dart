import 'package:front_gamific/core/models/add_group_data.dart';
import 'package:flutter/material.dart';

class AddGroupForm extends StatefulWidget {
  final void Function(AddGroupFormData) onSubmit;

  const AddGroupForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AddGroupForm> createState() => _AddGroupFormState();
}

class _AddGroupFormState extends State<AddGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AddGroupFormData();

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
                  key: const ValueKey('groupName'),
                  initialValue: _formData.groupName,
                  onChanged: (groupName) => _formData.groupName = groupName,
                  decoration: const InputDecoration(labelText: 'Nome do Grupo'),
                  validator: (name) {
                    final groupName = name ?? '';
                    if (groupName.trim().isEmpty) {
                      return 'O nome do Grupo dever ter ao menos uma letra.';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
