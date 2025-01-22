import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:tickets4devs/widgets/EventCard.dart';

class HomeScreen extends StatefulWidget {


  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final int _selectedIndex = 0;
  List<Event> events = [];
  String? errorMessage;
  bool isLoading = true;
  bool isPurchased = false;
  List<String> purchasedEventIds = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
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
            .removeItemFromCartById(Provider.of<UserNotifier>(context, listen: false).userLogado, eventId);
      } else {
        purchasedEventIds.add(eventId);
        //print(purchasedEventIds);
        Provider.of<Cart>(context, listen: false).addItemFromCartById(Provider.of<UserNotifier>(context, listen: false).userLogado, eventId);
      }
      //print('Eventos comprados: $purchasedEventIds');
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = [
      'https://media.istockphoto.com/id/1279483477/pt/foto/we-are-going-to-party-as-if-theres-no-tomorrow.jpg?s=612x612&w=0&k=20&c=rmnD3Ag-NN3CcvxWy3I92ZY2sz5gA1vDwE0vJCvhscE=',
      'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?cs=srgb&dl=pexels-wendywei-1190298.jpg&fm=jpg',
      'https://media.istockphoto.com/id/501387734/pt/foto/dan%C3%A7ar-seus-amigos.jpg?s=612x612&w=0&k=20&c=aHB1gZ5Qm6Glsl0n4RGR4oI8r_nxe5QI06TYlw9ifdg=',
    ];

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
                    'Tickets4Devs',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36,),
              const Text(
                'Bem-vindo ao Tickets4Devs!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: carouselImages.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 44),
              const Text(
                'Eventos próximos a você',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: events.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final event = events[index];
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
                    shouldBuy: false,
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