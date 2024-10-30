import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String email;

  const UserProfileScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: const Center(
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
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nome",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              "Email",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyLarge,
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
                  // Implementar lógica futura de edição ou logout aqui
                },
                icon: Icon(Icons.logout),
                label: Text("Sair da Conta"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
