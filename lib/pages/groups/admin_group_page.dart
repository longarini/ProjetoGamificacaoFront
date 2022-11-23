import 'package:flutter/material.dart';
import 'package:front_gamific/components/groups/datatable_comun_users.dart';
import 'package:front_gamific/core/services/groups/group_service.dart';
import '../../components/comun/nav_drawer.dart';

class AdminGroupPage extends StatefulWidget {
  final String idGroup;
  const AdminGroupPage({super.key, required this.idGroup});

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

  Future<List<Widget>> _getInformation(idGroup) async {
    List<Widget> retorno = [];

    var ret = await GroupServices().getInformation(idGroup);

    retorno.add(DataTableComunUsers(idGroup: idGroup));

    return retorno;
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
        title: const Text('Painel'),
      ),
      body: FutureBuilder(
        future: _getInformation(widget.idGroup),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: snapshot.data ?? [],
              ),
            );
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
