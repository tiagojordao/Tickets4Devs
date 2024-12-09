import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:tickets4devs/notifiers/EventNotifier.dart';

class EventDetail extends StatefulWidget {
  final String eventId;
  final String date;
  final double price;
  final String title;
  final String localId;
  final String descricao;
  bool isPurchased;
  final String creatorId; // ID do criador do evento
  final String userId; // ID do usuário logado
  final Function(String) togglePurchase;
  final Function onEventDeleted;

  EventDetail({
    super.key,
    required this.eventId,
    required this.date,
    required this.price,
    required this.title,
    required this.localId,
    required this.descricao,
    required this.isPurchased,
    required this.creatorId,
    required this.userId, // Adicionando o parâmetro para o usuário logado
    required this.togglePurchase,
    required this.onEventDeleted,
  });

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final int _selectedIndex = 0;
  late EventNotifier _userNotifier;

  @override
  void initState() {
    super.initState();
    _userNotifier = EventNotifier();
  }

  void _togglePurchase() {
    setState(() {
      widget.isPurchased = !widget.isPurchased;
    });
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
              onPressed: () async {
                Navigator.of(context).pop();
                await _userNotifier.deleteEvent(widget.eventId);
                widget.onEventDeleted();
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
              widget.descricao,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            Text(
              'Preço: R\$${widget.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 24.0),
            const Spacer(),
            
            // Verificando se o usuário logado é o criador do evento
            if (widget.creatorId == widget.userId) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showDeleteConfirmation(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Remover Evento'),
                ),
              ),
              const SizedBox(height: 16.0),
            ],

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
