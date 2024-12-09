import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/notifiers/EventNotifier.dart';

class EditEvent extends StatefulWidget {
  final String eventId;
  final String date;
  final double price;
  final String title;
  final String localId;
  final String descricao;

  const EditEvent({
    super.key,
    required this.eventId,
    required this.date,
    required this.price,
    required this.title,
    required this.localId,
    required this.descricao,
  });

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _priceController;
  late TextEditingController _localIdController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _dateController = TextEditingController(text: widget.date);
    _priceController = TextEditingController(text: widget.price.toString());
    _localIdController = TextEditingController(text: widget.localId);
    _descricaoController = TextEditingController(text: widget.descricao);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    _localIdController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
  final updatedEvent = {
    'title': _titleController.text,
    'date': _dateController.text,
    'price': double.parse(_priceController.text),
    'localId': _localIdController.text,
    'descricao': _descricaoController.text,
  };

  try {
    await EventNotifier().updateEvent(widget.eventId, updatedEvent);
    //Navigator.of(context).pop(updatedEvent); 
    GoRouter.of(context).push('/search');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao salvar alterações: $e')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Data',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Preço',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _localIdController,
              decoration: InputDecoration(
                labelText: 'Local',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFdbfc3b), // Cor de fundo amarela
                foregroundColor: Colors.black, // Cor do texto branco
              ),
              onPressed: _saveChanges,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}