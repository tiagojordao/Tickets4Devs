import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class EventsAvailable extends StatefulWidget {
  @override
  _EventsAvailableState createState() => _EventsAvailableState();
}

class _EventsAvailableState extends State<EventsAvailable> {
  final int _selectedIndex = 0;

  /* ESSA LISTA QUE ARMAZENA OS IDS COMPRADOS */
  List<String> purchasedEventIds = [];

  String searchQuery = '';

  final List<Event> events = [
    Event(
      id: '1',
      title: 'Halloween 2024',
      description: '',
      localId: 'Whiskritório, Natal',
      date: 'Sab, 30 OUT - 19:00',
      price: 15.99,
      totalTickets: 200,
    ),
    Event(
      id: '2',
      title: 'GGCON',
      description: '',
      localId: 'Centro de Convenções, Natal',
      date: 'Sab, 16 NOV - 10:00',
      price: 45.00,
      totalTickets: 500,
    ),
    Event(
      id: '3',
      title: 'Carnatal',
      description: '',
      localId: 'Arena das Dunas, Natal',
      date: 'Sab, 07 DEZ - 18:00',
      price: 500.00,
      totalTickets: 500,
    ),
  ];

  void _togglePurchase(String eventId) {
    setState(() {
      if (purchasedEventIds.contains(eventId)) {
        purchasedEventIds.remove(eventId);
      } else {
        purchasedEventIds.add(eventId);
      }
    });
  }

  List<Event> _getFilteredEvents() {
    if (searchQuery.isEmpty) {
      return events;
    }
    return events
        .where((event) =>
            event.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = _getFilteredEvents();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
                child: TextField(
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar eventos...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              ListView.builder(
                itemCount: filteredEvents.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  final isPurchased = purchasedEventIds.contains(event.id);
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
                                    event.date,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromRGBO(162, 194, 73, 1),
                                    ),
                                  ),
                                  Text(
                                    'R\$${event.price.toStringAsFixed(2)}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                        message: event.localId,
                                        child: Text(
                                          event.localId,
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
                                  _togglePurchase(event.id);
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
                },
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
