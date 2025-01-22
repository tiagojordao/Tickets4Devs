import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserTicketDetail extends StatelessWidget {
  final String titulo;
  final String dataCompra;
  final double preco;

  const UserTicketDetail({
    Key? key,
    required this.titulo,
    required this.dataCompra,
    required this.preco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo, textAlign: TextAlign.center),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título do Evento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              titulo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Data de Compra:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              dataCompra,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Preço:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'R\$ ${preco.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ingresso:',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 16),
                  PrettyQrView.data(data: 'presentation-ticket-00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
