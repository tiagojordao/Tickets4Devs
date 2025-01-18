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
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage)
                      : null,
                  child: profileImage == null
                      ? Icon(
                          Icons.person,
                          size: 60,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : null,
                ),
              ),
                const SizedBox(height: 20),
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
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      userNotifier.deslogar();
                      Navigator.pushReplacementNamed(context, '/');
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
      },
    );
  }
}