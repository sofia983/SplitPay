import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _keySessionToken = 'session_token';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserEmail = 'user_email';

  Future<void> saveSession({
    required String token,
    required String role,
    required String email,
  }) async {
    await _storage.write(key: _keySessionToken, value: token);
    await _storage.write(key: _keyUserRole, value: role);
    await _storage.write(key: _keyUserEmail, value: email);
  }

  Future<String?> getSessionToken() async {
    return await _storage.read(key: _keySessionToken);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: _keyUserRole);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _keyUserEmail);
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}