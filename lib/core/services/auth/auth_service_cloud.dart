import 'dart:async';
import 'package:front_gamific/core/models/auth_signup_data.dart';
import 'package:front_gamific/core/services/auth/auth_service.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

class AuthCloudService implements AuthService {
  static UserSignup? _currentUser;
  static MultiStreamController<UserSignup?>? _controller;
  static final _userStream = Stream<UserSignup?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  UserSignup? get currentUser {
    return _currentUser;
  }

  @override
  Stream<UserSignup?> get userChanges {
    return _userStream;
  }

  @override
  Future<String> signup(
    String user,
    String pwd,
    String email,
    String nome,
    String sobrenome,
  ) async {

    var url = Uri.http('localhost:3000', '/api/v1/user');
    var body = convert.jsonEncode({'user': user, 'pwd': pwd, 'email': email, 'nome': nome, 'sobrenome': sobrenome});
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return '';
    }else{
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['message'];
    }
  }

  @override
  Future<String> login(String user, String pwd) async {
    var url = Uri.http('localhost:3000', '/api/v1/login');
    var body = convert.jsonEncode({'user': user, 'pwd': pwd});

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      final newUser = UserSignup(
        user: user,
        pwd: "",
        email: "",
        nome: "",
        sobrenome: "",
        token: jsonResponse['token'],
      );
      await SessionManager().set("token", jsonResponse['token']);
      await SessionManager().set("id", jsonResponse['id']);
      _updateUser(newUser);
      return '';
    } else {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _updateUser(null);
      return jsonResponse['message'];
    }
  }

  @override
  Future<void> logout() async {
    await SessionManager().destroy();
    _updateUser(null);    
  }

  static void _updateUser(UserSignup? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
