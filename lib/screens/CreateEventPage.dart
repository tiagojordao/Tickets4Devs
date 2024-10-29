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
                    'Eventos',
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
                style: const TextStyle(
                    color: Color.fromRGBO(162, 194, 73, 1)), // Cor do texto
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(162, 194, 73, 1)), // Cor do label
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
                style: const TextStyle(
                    color: Color.fromRGBO(162, 194, 73, 1)), // Cor do texto
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(162, 194, 73, 1)), // Cor do label
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
                style: const TextStyle(
                    color: Color.fromRGBO(162, 194, 73, 1)), // Cor do texto
                decoration: InputDecoration(
                  labelText: 'Local',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(162, 194, 73, 1)), // Cor do label
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o local do evento';
                  }
                  return null;
                },
              ),

              // Campo para selecionar a data do evento
              // Campo para selecionar a data do evento
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label da Data
                      Text(
                        'Data',
                        style: const TextStyle(
                            color: Color.fromRGBO(
                                162, 194, 73, 1)), // Cor do label
                      ),
                      // Campo de entrada da data
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(
                                162, 194, 73, 1)), // Cor do texto
                        decoration: InputDecoration(
                          hintText: _selectedDate ?? 'Selecione a data',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(
                                  162, 194, 73, 1)), // Cor do hint
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(162, 194, 73,
                                    1)), // Cor da borda quando habilitado
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(162, 194, 73,
                                    1)), // Cor da borda quando focado
                          ),
                        ),
                        validator: (_) {
                          if (_selectedDate == null) {
                            return 'Por favor, selecione uma data';
                          }
                          return null;
                        },
                      ),
                      // Exibindo a data selecionada na cor desejada
                      if (_selectedDate != null)
                        Text(
                          _selectedDate!,
                          style: const TextStyle(
                              color: Color.fromRGBO(
                                  162, 194, 73, 1)), // Cor da data selecionada
                        ),
                    ],
                  ),
                ),
              ),

              // Campo para o preço do evento
              TextFormField(
                controller: _priceController,
                style: const TextStyle(
                    color: Color.fromRGBO(162, 194, 73, 1)), // Cor do texto
                decoration: InputDecoration(
                  labelText: 'Preço',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(162, 194, 73, 1)), // Cor do label
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
                style: const TextStyle(
                    color: Color.fromRGBO(162, 194, 73, 1)), // Cor do texto
                decoration: InputDecoration(
                  labelText: 'Total de Ingressos',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(162, 194, 73, 1)), // Cor do label
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
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text('Criar Evento'),
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
