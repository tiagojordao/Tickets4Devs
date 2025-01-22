import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickets4devs/models/User.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _profileImage;
  bool _isPickingImage = false;

  // Função para selecionar a imagem
  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    var picker = ImagePicker();
    try {
      var pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });

        String base64Image = await _convertImageToBase64(pickedFile);

        Provider.of<UserNotifier>(context, listen: false)
            .updateUserProfileImage(base64Image);
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  Future<String> _convertImageToBase64(XFile pickedFile) async {
    var bytes = await pickedFile.readAsBytes();
    return base64Encode(bytes);
  }

  File? _convertBase64ToFile(String base64String) {
    try {
      var bytes = base64Decode(base64String);
      var tempFilePath =
          '${Directory.systemTemp.path}/profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      var tempFile = File(tempFilePath);
      tempFile.writeAsBytesSync(bytes);
      return tempFile;
    } catch (e) {
      print('Erro ao converter Base64 para File: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, userNotifier, child) {
        var user = userNotifier.usuarioLogado;

        String? profileImageBase64 = user.profileImage;

        File? profileImage;
        if (profileImageBase64 != null && profileImageBase64.isNotEmpty) {
          profileImage = _convertBase64ToFile(profileImageBase64);
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30.0),
                ),
              ),
              child: AppBar(
                title: const Text(
                  'Perfil do Usuário',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    backgroundImage:
                        profileImage != null ? FileImage(profileImage) : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Toque para alterar a foto",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, color: Color(0xFFAECA1F)),
                            const SizedBox(width: 10),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.email, color: Color(0xFFAECA1F)),
                            const SizedBox(width: 10),
                            Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shadowColor: Color(0xFFdbfc3b),
                      elevation: 8,
                    ),
                    onPressed: () {
                      userNotifier.deslogar();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 24,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Sair da Conta",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: 0,
          ),
        );
      },
    );
  }
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
