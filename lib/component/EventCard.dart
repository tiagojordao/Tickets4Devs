import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool isPurchased;
  final VoidCallback onTogglePurchase;

  EventCard({
    required this.event,
    required this.isPurchased,
    required this.onTogglePurchase,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Evento informações (Data, Preço, Título)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.date,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(162, 194, 73, 1),
                      ),
                    ),
                    Text(
                      'R\$${event.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),

          // Localização e Botão de Compra/Remoção
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: Tooltip(
                          message: event.localId,
                          child: Text(
                            event.localId,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 120.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12.0),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: ElevatedButton.icon(
                  onPressed: onTogglePurchase,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    elevation: 0,
                  ),
                  label: Text(isPurchased ? 'Remover' : 'Comprar'),
                  icon: Icon(isPurchased
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
