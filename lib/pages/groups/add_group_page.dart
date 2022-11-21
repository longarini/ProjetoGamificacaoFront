import 'package:flutter/material.dart';
import 'package:front_gamific/components/groups/add_group_form.dart';
import 'package:front_gamific/core/models/add_group_data.dart';
import 'package:front_gamific/core/models/return_req_data.dart';
import 'package:front_gamific/core/services/groups/group_service.dart';
import 'package:front_gamific/pages/groups/admin_group_page.dart';
import 'package:front_gamific/pages/groups/group_page.dart';

import '../../components/comun/nav_drawer.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({super.key});

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {

  Future<void> _handleSubmit(AddGroupFormData formData) async {
    try {

      ReturnReq ret = await GroupServices().createGroup(formData.groupName);

      if(ret.status == 200){
      redirectPage(ret.data['_id']);
      }else{
        _showDialog('Erro', ret.msg);
      }
    } catch (error) {
      _showDialog('Error', error);
      //Implantar Tratamento.
    } finally {
    }
  }

  void redirectPage(groupId) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AdminGroupPage(idGroup: groupId,)));
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
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Groups.'),
      ),
      body: SingleChildScrollView(
        child: AddGroupForm(onSubmit: _handleSubmit),
      ),
    );
  }
}
