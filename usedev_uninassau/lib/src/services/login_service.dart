import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  LoginService._();

  static final LoginService instance = LoginService._();

  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'usedev_storage',
      publicKey: 'usedev_public_key',
    ),
  );

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw const LoginServiceException('Usuário ou senha inválidos.');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final token = data['token'];
      if (token is! String || token.isEmpty) {
        throw const LoginServiceException(
          'O servidor não retornou um token de autenticação válido.',
        );
      }

      await _storage.write(key: _tokenKey, value: token);
    } on LoginServiceException {
      rethrow;
    } on TimeoutException {
      throw const LoginServiceException(
        'A conexão demorou demais. Tente novamente.',
      );
    } on http.ClientException {
      throw const LoginServiceException(
        'Falha na conexão. Verifique sua internet.',
      );
    } on FormatException {
      throw const LoginServiceException(
        'O servidor retornou uma resposta inválida.',
      );
    } catch (_) {
      throw const LoginServiceException(
        'Não foi possível realizar o login. Tente novamente.',
      );
    }
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }
}

class LoginServiceException implements Exception {
  const LoginServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}
