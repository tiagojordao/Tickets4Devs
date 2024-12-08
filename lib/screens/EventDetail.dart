// ignore_for_file: file_names, unused_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventDetail extends StatefulWidget {
  final String eventId;
  final String date;
  final double price;
  final String title;
  final String localId;
  bool isPurchased;
  final Function(String) togglePurchase;
  final Function onEventDeleted;

  EventDetail({
    super.key,
    required this.eventId,
    required this.date,
    required this.price,
    required this.title,
    required this.localId,
    required this.isPurchased,
    required this.togglePurchase,
    required this.onEventDeleted,
  });

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final int _selectedIndex = 0;

  void _togglePurchase() {
    setState(() {
      widget.isPurchased = !widget.isPurchased;
    });
  }

  void _deleteEventFromDatabase(String eventId) async {
    try {
      final String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/events/${Uri.encodeFull(eventId)}.json';

      print(eventId);

      final responseGet = await http.get(Uri.parse(firebaseUrl));
      if (responseGet.statusCode != 200 || responseGet.body == 'null') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evento não encontrado para exclusão!')),
        );
        return;
      }

      // Enviar requisição DELETE para o Firebase
      final response = await http.delete(Uri.parse(firebaseUrl));
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evento removido com sucesso!')),
        );

        // Atualizar o estado ou fazer outras ações necessárias
        /*setState(() {
          // Atualizar o estado
        }); */
        widget.onEventDeleted();
        Navigator.of(context).pop(true);
      } else {
        throw Exception('Erro ao remover evento: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover evento: $e')),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar remoção'),
          content: Text('Tem certeza de que deseja remover este evento?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _deleteEventFromDatabase(widget.eventId);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Evento removido com sucesso!'),
                  ),
                );
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            AppBar(
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              elevation: 0,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.date_range),
                Text(
                  '  ${widget.date}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8.0),
                Text(
                  widget.localId,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Text(
              'Descrição',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Sem descrição!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            Text(
              'Preço: R\$${widget.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 24.0),
            const SizedBox(height: 8.0),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Botão com cor vermelha
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Função de remoção
                  _showDeleteConfirmation(context);
                },
                icon: Icon(Icons.delete),
                label: Text('Remover Evento'),
              ),
            ),
            const SizedBox(height: 16.0), // Espaço entre os botões

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {
                  _togglePurchase();
                  widget.togglePurchase(widget.title);
                },
                icon: Icon(widget.isPurchased
                    ? Icons.remove_shopping_cart
                    : Icons.add_shopping_cart),
                label: Text(widget.isPurchased ? 'Remover' : 'Comprar'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
