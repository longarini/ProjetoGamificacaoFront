import 'package:flutter/material.dart';
import 'package:front_gamific/core/models/group_data.dart';
import '../../components/comun/nav_drawer.dart';
import '../../core/services/groups/group_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
  
}

class _MainPageState extends State<MainPage> {
  var groups = List<GroupData>;
  @override
  void initState(){
    super.initState();
    _getGroups();
  }
  


  void _getGroups() {
    //groups = await GroupServices().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Tasks.'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}