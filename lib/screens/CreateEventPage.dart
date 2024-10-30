import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final int _selectedIndex = 0;
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

      // adicionar logica para salvamento

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
                    'Crie seu Evento',
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para o título do evento
              TextFormField(
                controller: _titleController,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16, // Tamanho da fonte do texto
                ),
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 16, // Tamanho da fonte do label
                  ),
                ),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 16,
                  ),
                ),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Local',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 16,
                  ),
                ),
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
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    decoration: InputDecoration(
                      hintText: _selectedDate ?? 'Selecione a data',
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Preço',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 16,
                  ),
                ),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Total de Ingressos',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 16,
                  ),
                ),
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
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: _saveEvent,
                  child: const Text(
                    'Criar Evento',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 4,
            thickness: 2,
            color: Colors.black,
          ),
          BottomNavBar(
            selectedIndex: _selectedIndex,
          ),
        ],
      ),
    );
  }
}
