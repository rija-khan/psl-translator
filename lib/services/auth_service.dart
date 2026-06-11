import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalUser {
  const LocalUser({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;

  Map<String, String> toJson() => {
        'username': username,
        'email': email,
        'password': password,
      };

  static LocalUser? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final username = value['username'];
    final email = value['email'];
    final password = value['password'];
    if (username is! String || email is! String || password is! String) {
      return null;
    }
    return LocalUser(username: username, email: email, password: password);
  }
}

class AuthResult {
  const AuthResult.success() : message = null;
  const AuthResult.failure(this.message);

  final String? message;
  bool get isSuccess => message == null;
}

class AuthService {
  static const _usersKey = 'auth_users';
  static const _tokenKey = 'auth_token';
  static const _currentEmailKey = 'auth_current_email';

  Future<bool> hasValidSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final email = prefs.getString(_currentEmailKey);
    if (token == null || token.isEmpty || email == null || email.isEmpty) {
      return false;
    }
    final users = await _loadUsers(prefs);
    return users.any((user) => user.email.toLowerCase() == email.toLowerCase());
  }

  Future<LocalUser?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_currentEmailKey);
    if (email == null || email.isEmpty) return null;
    final users = await _loadUsers(prefs);
    for (final user in users) {
      if (user.email.toLowerCase() == email.toLowerCase()) {
        return user;
      }
    }
    return null;
  }

  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final cleanUsername = username.trim();
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanUsername.isEmpty || cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return const AuthResult.failure('All fields are required.');
    }
    if (!cleanEmail.contains('@') || !cleanEmail.contains('.')) {
      return const AuthResult.failure('Enter a valid email address.');
    }
    if (cleanPassword.length < 6) {
      return const AuthResult.failure('Password must be at least 6 characters.');
    }

    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    final usernameTaken = users.any(
      (user) => user.username.toLowerCase() == cleanUsername.toLowerCase(),
    );
    if (usernameTaken) {
      return const AuthResult.failure('Username already exists.');
    }
    final emailTaken = users.any(
      (user) => user.email.toLowerCase() == cleanEmail,
    );
    if (emailTaken) {
      return const AuthResult.failure('Email already exists.');
    }

    users.add(
      LocalUser(
        username: cleanUsername,
        email: cleanEmail,
        password: cleanPassword,
      ),
    );
    await _saveUsers(prefs, users);
    return const AuthResult.success();
  }

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();
    if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return const AuthResult.failure('Email and password are required.');
    }

    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    final matches = users.where(
      (user) =>
          user.email.toLowerCase() == cleanEmail &&
          user.password == cleanPassword,
    );
    if (matches.isEmpty) {
      return const AuthResult.failure('Email or password is incorrect.');
    }

    final token = base64Url.encode(
      utf8.encode('$cleanEmail:${DateTime.now().microsecondsSinceEpoch}'),
    );
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_currentEmailKey, matches.first.email);
    return const AuthResult.success();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_currentEmailKey);
  }

  Future<void> deleteCurrentAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_currentEmailKey);
    if (email == null || email.isEmpty) {
      await logout();
      return;
    }
    final users = await _loadUsers(prefs);
    users.removeWhere((user) => user.email.toLowerCase() == email.toLowerCase());
    await _saveUsers(prefs, users);
    await logout();
  }

  Future<List<LocalUser>> _loadUsers(SharedPreferences prefs) async {
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = json.decode(raw);
      if (decoded is! List) return [];
      return decoded.map(LocalUser.fromJson).whereType<LocalUser>().toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveUsers(
    SharedPreferences prefs,
    List<LocalUser> users,
  ) async {
    final raw = json.encode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, raw);
  }
}
