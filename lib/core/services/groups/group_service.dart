import 'dart:async';
import 'dart:convert';
import 'package:front_gamific/core/models/group_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:front_gamific/core/models/return_req_data.dart';

import '../../models/group/retorno_group.dart';

class GroupServices {
  Future<ReturnReq> getGroups() async {
    dynamic id = await SessionManager().get("id");
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/groups/$id');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json", 'x-access-token': token},
      );

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.body).cast<Map<String, dynamic>>();

        retorno.data = jsonResponse
            .map<GroupData>((json) => GroupData.fromJson(json))
            .toList();
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }

  Future<ReturnReq> createGroup(nomeGrupo) async {
    dynamic id = await SessionManager().get("id");
    dynamic token = await SessionManager().get("token");

    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/groups');
    var body = jsonEncode({
      'idUser': id,
      'groupName': nomeGrupo,
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json", 'x-access-token': token},
        body: body,
      );

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        retorno.data = jsonResponse;
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }

  Future<ReturnReq> getInformation(idGroup) async {
    dynamic id = await SessionManager().get("id");
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/groups/$id/$idGroup');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json", 'x-access-token': token},
      );

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        retorno.data = RetornoGroup.fromJson(jsonResponse);
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }

  Future<ReturnReq> deleteUser(user, idGroup) async {
    dynamic token = await SessionManager().get("token");
    ReturnReq retorno = ReturnReq(status: 200, msg: '', data: null);

    var url = Uri.http('localhost:3000', '/api/v1/groups');
    var body = jsonEncode({'id': idGroup, 'user': user});
    try {
      var response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            'x-access-token': token
          },
          body: body);

      retorno.status = response.statusCode;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        retorno.data = RetornoGroup.fromJson(jsonResponse);
      }
    } catch (err) {
      retorno.msg = err.toString();
    }
    return retorno;
  }
}
