import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    var tempFilePath = '${Directory.systemTemp.path}/profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 151, 180, 7), Color(0xFFdbfc3b)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
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
                  icon: const Icon(Icons.logout, size: 24),
                  label: const Text(
                    "Sair da Conta",
                    style: TextStyle(fontSize: 16),
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