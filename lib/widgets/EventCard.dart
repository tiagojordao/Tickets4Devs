// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {

  final String date;
  final double price;
  final String title;
  final String localId;
  final String eventId;
  final bool isPurchased;
  final Function(String) togglePurchase;
  
  const EventCard({
      super.key,
      required this.date,
      required this.price,
      required this.title,
      required this.localId,
      required this.eventId,
      required this.isPurchased,
      required this.togglePurchase,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      margin: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(162, 194, 73, 1),
                      ),
                    ),
                    Text(
                      'R\$${price.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: Tooltip(
                          message: localId,
                          child: Text(
                            localId,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
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
                  onPressed: () {
                    togglePurchase(eventId);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    elevation: 0,
                  ),
                  label:
                      Text(isPurchased ? 'Remover' : 'Comprar'),
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