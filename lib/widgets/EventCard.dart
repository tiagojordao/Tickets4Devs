// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:tickets4devs/screens/EventDetail.dart';

class EventCard extends StatefulWidget {
  final String id;
  final String date;
  final double price;
  final String title;
  final String localId;
  final String descricao;
  final bool isPurchased;
  final Function(String) togglePurchase;
  final Function onEventDeleted;

  const EventCard({
    super.key,
    required this.id,
    required this.date,
    required this.price,
    required this.title,
    required this.localId,
    required this.descricao,
    required this.isPurchased,
    required this.togglePurchase,
    required this.onEventDeleted,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late bool inCart;

  @override
  void initState() {
    super.initState();
    inCart = widget.isPurchased;
  }

  void _toggleCartState() {
    setState(() {
      inCart = !inCart;
    });
    widget.togglePurchase(widget.id);
  }

  void _openEventDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetail(
          eventId: widget.id,
          date: widget.date,
          price: widget.price,
          title: widget.title,
          localId: widget.localId,
          descricao: widget.descricao,
          isPurchased: inCart,
          togglePurchase: (event) {
            _toggleCartState();
          },
          onEventDeleted: () {
            widget.onEventDeleted();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openEventDetail,
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(162, 194, 73, 1),
                        ),
                      ),
                      Text(
                        'R\$${widget.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.title,
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
                            message: widget.localId,
                            child: Text(
                              widget.localId,
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
                    onPressed: _toggleCartState,
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
                    label: Text(inCart ? 'Remover' : 'Comprar'),
                    icon: Icon(
                      inCart
                          ? Icons.remove_shopping_cart
                          : Icons.add_shopping_cart,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
