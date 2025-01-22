import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tickets4devs/db/CartDB.dart';
import 'package:tickets4devs/models/Event.dart';
import 'package:tickets4devs/models/Ticket.dart';

class Cart extends ChangeNotifier {
  CartDB cartDB = CartDB();
  List<Event> _shopItems = []; 
  bool isLoading = true;
  String? errorMessage;
  bool get loadingStatus => isLoading;
  String? get error => errorMessage;

  // Método para buscar os eventos
  Future<void> fetchEvents() async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/events.json';

      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body); 

        _shopItems = data.entries
            .where((entry) => entry.value != null)
            .map((entry) {
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
            })
            .toList();
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar eventos: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage = e.toString();
      print("erro:");
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  List<Event> _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  get cartItemsId{
    List<String> cartItemsId = [];
    for (var i = 0; i < _cartItems.length; i++) {
      cartItemsId.add(_cartItems[i].id);
    }
    return cartItemsId;
  }

  void clearCard(){
    _cartItems = [];
  }

   Future<void> addItemFromCartById(String userId, String eventId) async {
    final event = _shopItems.firstWhere((item) => item.id == eventId);
    if (event != null) {
      _cartItems.add(event);
      await cartDB.insertItem(userId, eventId);
      notifyListeners();
    }
  }

  void removeItemFromCartById(String userId, String eventId) async{
      final index = _cartItems.indexWhere((item) => item.id == eventId);
      if (index != -1) {
        print("Removido do carrinho: ${_cartItems[index].title}");
        _cartItems.removeAt(index);
        await cartDB.removeItem(userId, eventId);
        notifyListeners();
      }
  }

  String calculateTotal(){
    double totalPrice = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      totalPrice += _cartItems[i].price;
    }
    return totalPrice.toStringAsFixed(2);
  }

  Future<void> purchaseTickets(String userId) async {
    try {

      var response;
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/tickets.json';


      for (var event in _cartItems) {
        Ticket t = new Ticket(
          id: '',
          userId: userId,
          eventId: event.id,
          purchaseDate: DateTime.now(),
          price: event.price
        );

        response = await http.post(
          Uri.parse(firebaseUrl),
          body: jsonEncode(t)
        );
      }

      if(response.statusCode == 200) {
        print('Tickets adicionados com sucesso!');
        notifyListeners();
      } 
      else {
        throw Exception('Erro ao comprar tickets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao comprar tickets: $e');
    }
  }

  Future<void> syncCart(String userId) async {
    await fetchEvents();
    final cartEventIds = await cartDB.getUserCart(userId);

    for (final eventId in cartEventIds) {
        try {
            final event = _shopItems.firstWhere((item) => item.id == eventId);
            if (event != null && !_cartItems.contains(event)) {
                _cartItems.add(event);
            }
        } catch (e) {
            print("Evento com ID $eventId não encontrado: $e");
        }
    }
    notifyListeners();
}
}