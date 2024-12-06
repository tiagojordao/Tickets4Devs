import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tickets4devs/models/Event.dart';

class Cart extends ChangeNotifier {
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
        final List<dynamic> data = jsonDecode(response.body);

        _shopItems = data
            .where((event) => event != null)
            .map((eventData) {
              return Event(
                id: eventData['id'] ?? '',
                title: eventData['title'] ?? '',
                description: eventData['description'] ?? '',
                localId: eventData['localId'] ?? '',
                date: eventData['date'] ?? '',
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
      isLoading = false;
      notifyListeners();
    }
  }

  List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  get cartItemsId{
    List<int> cartItemsId = [];
    for (var i = 0; i < _cartItems.length; i++) {
      cartItemsId.add(_cartItems[i].id);
    }
    return cartItemsId;
  }

  void addItemToCard(int index){
    if ((index <= _shopItems.length)) {
      _cartItems.add(_shopItems[index-1]);
      print("Adicionado ao carrinho : " + _shopItems[index-1].title);
      notifyListeners();
    }
  }

  void removeItemFromCart(int index){
    if ((index <= _shopItems.length)) {
      for (var i = 0; i < _cartItems.length; i++) {
        if (_cartItems[i].id == _shopItems[index-1].id) {
          _cartItems.removeAt(i);
        }
      }
      print("Removido do carrinho : " + _shopItems[index-1].title);
      notifyListeners();
    }
  }

  void removeItemFromCartById(int id){
      for (var i = 0; i < _cartItems.length; i++) {
        if (_cartItems[i].id == id) {
          print("Removido do carrinho : " + _cartItems[i].title);
          _cartItems.removeAt(i);
        }
      }
      notifyListeners();
  }

  String calculateTotal(){
    double totalPrice = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      totalPrice += _cartItems[i].price;
    }
    return totalPrice.toStringAsFixed(2);
  }
}