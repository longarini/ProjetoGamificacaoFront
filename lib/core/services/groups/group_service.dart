import 'dart:async';
import 'dart:convert';
import 'package:front_gamific/core/models/group_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

class GroupServices{

  Future<List<GroupData>> getGroups() async {
    dynamic id = await SessionManager().get("id");
    dynamic token = await SessionManager().get("token");
    List<GroupData> retorno = [];

    var url = Uri.http('localhost:3000', '/api/v1/groups/$id');

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'x-access-token': token 
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body).cast<Map<String, dynamic>>();

      retorno = jsonResponse.map<GroupData>((json) => GroupData.fromJson(json)).toList();
      } 
      return retorno;
  }
}