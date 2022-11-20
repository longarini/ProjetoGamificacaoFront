import 'package:flutter/material.dart';
import 'package:front_gamific/components/groups/datatable_comun_users.dart';
import '../../components/comun/nav_drawer.dart';

class AdminGroupPage extends StatefulWidget {
  const AdminGroupPage({super.key});

  @override
  State<AdminGroupPage> createState() => _AdminGroupPageState();
}

class _AdminGroupPageState extends State<AdminGroupPage> {
  // Future<void> _handleSubmit(AddGroupFormData formData) async {
  //   try {

  //     ReturnReq ret = await GroupServices().createGroup(formData.groupName);

  //     if(ret.status == 200){
  //     redirectPage();
  //     }else{
  //       _showDialog('Erro', ret.msg);
  //     }
  //   } catch (error) {
  //     _showDialog('Error', error);
  //     //Implantar Tratamento.
  //   } finally {
  //   }
  // }

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
      body: const DataTableComunUsers(),
    );
  }
}
