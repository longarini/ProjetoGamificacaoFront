import 'dart:async';
import 'dart:convert';
import 'package:front_gamific/core/models/task_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

class TaskServices {
  Future<List<TaskData>> getTasks(idGroup) async {
    dynamic token = await SessionManager().get("token");
    List<TaskData> retorno = [];

    var url = Uri.http('localhost:3000', '/api/v1/tasks/$idGroup');

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", 'x-access-token': token},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body).cast<Map<String, dynamic>>();

      retorno = jsonResponse
          .map<TaskData>((json) => TaskData.fromJson(json))
          .toList();
    }
    return retorno;
  }
}
