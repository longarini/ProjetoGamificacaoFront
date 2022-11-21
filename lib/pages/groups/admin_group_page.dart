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

  Future<int> _getInformation(idGroup) async {
    var ret = await GroupServices().getInformation(idGroup);

    var data = ret.data;
    return 0;
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
            return GridView(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [],
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
