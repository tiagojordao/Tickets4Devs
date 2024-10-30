// ignore_for_file: file_names, unused_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class EventDetail extends StatefulWidget {

  final String date;
  final double price;
  final String title;
  final String localId;
  bool isPurchased;
  final Function(String) togglePurchase;
  
  EventDetail({
      super.key,
      required this.date,
      required this.price,
      required this.title,
      required this.localId,
      required this.isPurchased,
      required this.togglePurchase,
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
