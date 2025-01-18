// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:tickets4devs/models/UserNotifier.dart';
=======
import 'package:provider/provider.dart';
import 'package:tickets4devs/models/User.dart';
>>>>>>> bf6df28518e66e31fb9c241a3cd8d886d34ff8b8
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';

import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _profileImage;
  bool _isPickingImage = false; 

  Future<void> _pickImage() async {
    if (_isPickingImage) return; 

    setState(() {
      _isPickingImage = true;
    });

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });

        // Aqui você pode salvar a imagem no backend ou Firebase Storage
        // E atualizar a URL da imagem no perfil do usuário.
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    } finally {
      setState(() {
        _isPickingImage = false; // Libera para novas chamadas
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
<<<<<<< HEAD
    final user = userNotifier.usuarioLogado;
=======
    final user = Provider.of<UserNotifier>(context).user;
>>>>>>> bf6df28518e66e31fb9c241a3cd8d886d34ff8b8

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30.0),
                ),
              ),
              child: AppBar(
                title: Center(
                  child: Text(
                    'Perfil do Usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColorLight,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
<<<<<<< HEAD
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Text(
                  ' ${user.name}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                Text(
                  ' ${user.email}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
=======
            _buildUserInfoRow(
              context,
              icon: Icons.person,
              label: 'Nome',
              value: user.name,
            ),
            const SizedBox(height: 15),
            _buildUserInfoRow(
              context,
              icon: Icons.email,
              label: 'E-mail',
              value: user.email,
>>>>>>> bf6df28518e66e31fb9c241a3cd8d886d34ff8b8
            ),
            const SizedBox(height: 15),
            _buildUserInfoRow(
              context,
              icon: Icons.lock,
              label: 'Senha',
              value: '********',
            ),
            const SizedBox(height: 15),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {
                  _showEditModal(context, userNotifier);
                },
                icon: Icon(Icons.edit),
                label: Text("Editar Perfil"),
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {
<<<<<<< HEAD
                  userNotifier.deslogar();
                  Navigator.pushReplacementNamed(context, '/');
=======
                  Provider.of<UserNotifier>(context, listen: false).deslogar();
                  Provider.of<Cart>(context, listen: false).clearCard();
                  context.go('/');
>>>>>>> bf6df28518e66e31fb9c241a3cd8d886d34ff8b8
                },
                icon: Icon(Icons.logout),
                label: Text("Sair da Conta"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
<<<<<<< HEAD
}
=======
}




Widget _buildUserInfoRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  void _showEditModal(BuildContext context, UserNotifier userNotifier) {
    final user = userNotifier.user!;
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController(text: '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Dados do Usuário',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final updatedUser = User(
                      id: user.id,
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text.isNotEmpty
                          ? passwordController.text
                          : user.password,
                    );
                    userNotifier.updateUser(updatedUser);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Salvar Alterações',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

>>>>>>> bf6df28518e66e31fb9c241a3cd8d886d34ff8b8
