import 'dart:convert'; // Para converter JSON
import 'package:flutter/material.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:tickets4devs/widgets/EventCard.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EventsAvailable extends StatefulWidget {
  const EventsAvailable({super.key});

  @override
  _EventsAvailableState createState() => _EventsAvailableState();
}

class _EventsAvailableState extends State<EventsAvailable> {
  final int _selectedIndex = 0;

  /* ESSA LISTA QUE ARMAZENA OS IDS COMPRADOS */
  List<String> purchasedEventIds = [];
  String searchQuery = '';

  List<Event> events = [];
  bool isLoading = true;
  bool isPurchased = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    Provider.of<Cart>(context, listen: false).fetchEvents();
    purchasedEventIds = Provider.of<Cart>(context, listen: false).cartItemsId;
    //print( Provider.of<Cart>(context, listen: false).shopItems);
  }

  Future<void> _fetchEvents() async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/events.json';

      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        setState(() {
          events =
              data.entries.where((entry) => entry.value != null).map((entry) {
            final eventData = entry.value;
            return Event(
              id: entry.key,
              title: eventData['title'] ?? '',
              description: eventData['description'] ?? '',
              localId: eventData['localId'] ?? '',
              date: eventData['date'] ?? '',
              criador: eventData['criador'] ?? '',
              price: double.tryParse(eventData['price'].toString()) ?? 0.0,
              totalTickets:
                  int.tryParse(eventData['totalTickets'].toString()) ?? 0,
            );
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar eventos: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _togglePurchase(String eventId) {
    //print( Provider.of<Cart>(context, listen: false).shopItems);
    setState(() {
      if (purchasedEventIds.contains(eventId)) {
        purchasedEventIds.remove(eventId);
        //print(purchasedEventIds);
        Provider.of<Cart>(context, listen: false)
            .removeItemFromCartById(eventId);
      } else {
        purchasedEventIds.add(eventId);
        //print(purchasedEventIds);
        Provider.of<Cart>(context, listen: false).addItemFromCartById(eventId);
      }
      //print('Eventos comprados: $purchasedEventIds');
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 4.0),
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                              hintText: 'Pesquisar eventos...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).primaryColorLight,
                              prefixIcon: Icon(Icons.search,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                            isPurchased = purchasedEventIds.contains(event.id);
                            return EventCard(
                              id: event.id,
                              date: event.date,
                              price: event.price,
                              title: event.title,
                              localId: event.localId,
                              descricao: event.description,
                              isPurchased: isPurchased,
                              creator: event.criador,
                              user: Provider.of<UserNotifier>(context, listen: false).userLogado,
                              togglePurchase: (eventid) {
                                _togglePurchase(eventid);
                              },
                              onEventDeleted: _fetchEvents,
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
