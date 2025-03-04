import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets4devs/models/User.dart';

class UserNotifier extends ChangeNotifier {
  List<User> _users = [];
  late User usuarioLogado;
  bool isLoggedIn = false;
  bool isLoading = true;
  String? errorMessage;

  bool get loadingStatus => isLoading;
  String? get error => errorMessage;
  User get user => usuarioLogado;

  Future<void> fetchUsers() async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/users.json';

      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        _users = data.entries
            .where((entry) => entry.value != null)
            .map((entry) {
              final userData = entry.value;
              return User(
                id: entry.key,
                email: userData['email'] ?? '',
                name: userData['name'] ?? '',
                password: userData['password'] ?? '',
                profileImage: userData['profileImage'] ?? '', // Novo campo
              );
            })
            .toList();

        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar eventos: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  get users => _users;

  get userLogado => usuarioLogado.id;

  Future<void> saveLoginToSharedPreferences(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  bool login(String email, String password) {

    print('Email: $email');
    print('Password: $password');
    print('Users: $_users');

    for (var i = 0; i < _users.length; i++) {
      if (email == _users[i].email) {
        if (password == _users[i].password) {
          isLoggedIn = true;
          usuarioLogado = _users[i];

          print('User1: $usuarioLogado');

          saveLoginToSharedPreferences(_users[i].email, _users[i].password);

          print('User2: $usuarioLogado');

          notifyListeners();
          return true;
        }
      }
    }
    return false;
  }

  Future<void> deslogar() async {
    if (isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      isLoggedIn = false;
      notifyListeners();
    }
  }

  bool emailValido(String email) {
    for (var i = 0; i < _users.length; i++) {
      if (_users[i].email == email) {
        return false;
      }
    }
    return true;
  }

  Future<void> registerUser(String email, String name, String password) async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/users.json';

      final response = await http.post(
        Uri.parse(firebaseUrl),
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'profileImage': '', // Inicializa o campo com um valor vazio
        }),
      );

      if (response.statusCode == 200) {
        await fetchUsers();
        notifyListeners();
      } else {
        throw Exception('Erro ao cadastrar usuário: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
      notifyListeners();
    }
  }

 Future<void> updateUserProfileImage(String imageUrl) async {
  try {

    final String firebaseUrl =
        'https://tickets4devs2024-default-rtdb.firebaseio.com/users/${usuarioLogado.id}.json';

    final response = await http.put(
      Uri.parse(firebaseUrl),
      body: jsonEncode({
        'email': usuarioLogado.email,
        'name': usuarioLogado.name,
        'password': usuarioLogado.password,
        'profileImage': imageUrl, 
      }),
    );

    if (response.statusCode == 200) {
      usuarioLogado.profileImage = imageUrl;

      notifyListeners();
    } else {
      throw Exception('Erro ao atualizar o perfil: ${response.statusCode}');
    }
  } catch (e) {
    print("Erro ao atualizar o perfil: $e");
  }
}

  Future<void> removeUser(String userId) async {
    try {
      final user = _users.firstWhere((user) => user.id == userId);

      final String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/users/${user.id}.json';

      final response = await http.delete(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        print("Usuário excluído com sucesso.");
        await fetchUsers();
        notifyListeners();
      } else {
        throw Exception('Erro ao remover usuário: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao tentar excluir o usuário: $e');
    }
  }

  void updateUser(User aUser) async {
    final user = _users.firstWhere((user) => user.id == aUser.id);

    final String firebaseUrl =
        'https://tickets4devs2024-default-rtdb.firebaseio.com/users/${user.id}.json';

    if (user != null) {
      final response = await http.put(
        Uri.parse(firebaseUrl),
        body: jsonEncode({
          'email': aUser.email ?? aUser.email != null,
          'name': aUser.name ?? aUser.name != null,
          'password': aUser.password ?? aUser.password != null,
        }),
      );
    }

    if (usuarioLogado != null) {
      usuarioLogado = User(
        id: usuarioLogado.id,
        name: aUser.name ?? usuarioLogado.name,
        email: aUser.email ?? usuarioLogado.email,
        password: aUser.password ?? usuarioLogado.password,
        profileImage: usuarioLogado.profileImage, 
      );
      notifyListeners();
    } else {
      throw Exception('Nenhum usuário logado para atualizar.');
    }
  }
}