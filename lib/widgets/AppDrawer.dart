import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/screens/CreateEventPage.dart';
import 'package:tickets4devs/screens/QRCodeScannerScreen.dart';
import 'package:tickets4devs/screens/UserProfileScreen.dart';
import 'package:tickets4devs/screens/WalletScreen.dart';

class AppDrawer extends StatelessWidget {

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

        return Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  accountEmail: Text(user.email,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: profileImage != null ? FileImage(profileImage) : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserProfileScreen(),)
                    );
                    // context.go('/qrCodeScanner');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.qr_code),
                  title: Text('Validar Ingresso'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QRCodeScannerScreen(),)
                    );
                    // context.go('/qrCodeScanner');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wallet),
                  title: Text('Carteira'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WalletScreen(),)
                    );
                    // context.go('/qrCodeScanner');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Criar Evento'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreateEventPage(),)
                    );
                    // context.go('/qrCodeScanner');
                  },
                ),
              ],
            ),
          );
      }
    );
  }
}