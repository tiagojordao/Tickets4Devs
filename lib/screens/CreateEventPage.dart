import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Event.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _localController = TextEditingController();
  final _priceController = TextEditingController();
  final _ticketsController = TextEditingController();
  String? _selectedDate;

  // Função para exibir um Date Picker
  Future<void> _pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = "${selectedDate.day.toString().padLeft(2, '0')}/"
            "${selectedDate.month.toString().padLeft(2, '0')}/"
            "${selectedDate.year}";
      });
    }
  }

  // Função para salvar o evento
  void _saveEvent() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final newEvent = Event(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        localId: _localController.text,
        date: _selectedDate!, // Armazena a data como string
        price: double.parse(_priceController.text),
        totalTickets: int.parse(_ticketsController.text),
      );

      // Aqui você pode fazer algo com o evento, como enviá-lo a um backend

      // Exemplo de feedback visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Evento "${newEvent.title}" criado!')),
      );

      // Limpar os campos após criar o evento
      _formKey.currentState!.reset();
      setState(() {
        _selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para o título do evento
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título do evento';
                  }
                  return null;
                },
              ),

              // Campo para a descrição do evento
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),

              // Campo para o local do evento
              TextFormField(
                controller: _localController,
                decoration: InputDecoration(labelText: 'Local'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o local do evento';
                  }
                  return null;
                },
              ),

              // Campo para selecionar a data do evento
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data',
                      hintText: _selectedDate ?? 'Selecione a data',
                    ),
                    validator: (_) {
                      if (_selectedDate == null) {
                        return 'Por favor, selecione uma data';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              // Campo para o preço do evento
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico';
                  }
                  return null;
                },
              ),

              // Campo para a quantidade total de ingressos
              TextFormField(
                controller: _ticketsController,
                decoration: InputDecoration(labelText: 'Total de Ingressos'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de ingressos';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Botão para salvar o evento
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text('Criar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
