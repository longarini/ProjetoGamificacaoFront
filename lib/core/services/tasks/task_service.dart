import 'dart:async';
import 'dart:convert';
import 'package:front_gamific/core/models/return_req_data.dart';
import 'package:front_gamific/core/models/task/retorno_task.dart';
import 'package:front_gamific/core/models/task_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

class TaskServices {
  Future<ReturnReq> getTasks(idGroup) async {
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: []);

    var url = Uri.http('localhost:3000', '/api/v1/tasks/$idGroup');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json", 'x-access-token': token},
      );

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        jsonResponse.forEach((element) {
          retorno.data.add(RetornoTask.fromJson(element));
        });
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }

  Future<ReturnReq> deleteTask(idTask) async {
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/tasks');
    var body = jsonEncode({'id': idTask});
    try {
      var response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'x-access-token': token
          },
          body: body);

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        retorno.data = RetornoTask.fromJson(jsonResponse);
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }

  Future<ReturnReq> insertTask(idGroup, name, descricao, pontos) async {
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/tasks');
    var body = jsonEncode({
      'groupId': idGroup,
      'name': name,
      'descricao': descricao,
      'pontos': pontos
    });
    try {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            'x-access-token': token
          },
          body: body);

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        retorno.data = RetornoTask.fromJson(jsonResponse);
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }
}
