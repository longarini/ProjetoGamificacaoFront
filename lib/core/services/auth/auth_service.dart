import '../../models/auth_signup_data.dart';

abstract class AuthService {
  UserSignup? get currentUser;

  Stream<UserSignup?> get userChanges;

  Future<void> signup(
    String user,
    String pwd,
    String email,
    String nome,
    String sobrenome,
  );
  Future<void> login(
    String user,
    String pwd,
  );
  Future<void> logout();
}
