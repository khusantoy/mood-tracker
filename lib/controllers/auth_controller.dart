import 'package:mood_tracker/services/auth_firebase_services.dart';

class AuthController {
  final _authFirebaseServices = AuthFirebaseServices();

  Future<void> login({
    required String emailAddress,
    required String password,
  }) async {
    await _authFirebaseServices.login(
      emailAddress: emailAddress,
      password: password,
    );
  }

  Future<void> register({
    required String emailAddress,
    required String password,
  }) async {
    await _authFirebaseServices.register(
      emailAddress: emailAddress,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authFirebaseServices.logout();
  }

  Future<void> resetPassword({required String email}) async {
    await _authFirebaseServices.resetPassword(email: email);
  }
}
