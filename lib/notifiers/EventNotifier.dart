import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventNotifier extends ChangeNotifier {
  
  Future<void> saveEventToDatabase(Map<String, dynamic> eventData) async {
    const String firebaseUrl =
        'https://tickets4devs2024-default-rtdb.firebaseio.com/events.json';

    try {
      final response = await http.post(
        Uri.parse(firebaseUrl),
        body: jsonEncode(eventData),
      );

      if (response.statusCode == 200) {
        // Apenas notifica que o evento foi salvo
        notifyListeners();
      } else {
        throw Exception('Erro ao salvar evento: ${response.statusCode}');
      }
    } catch (e) {
      // Notifica erro ao salvar o evento
      throw Exception('Erro ao criar evento: $e');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    await _deleteEventFromDatabase(eventId);
  }

  Future<void> _deleteEventFromDatabase(String eventId) async {
    final String firebaseUrl =
        'https://tickets4devs2024-default-rtdb.firebaseio.com/events/${Uri.encodeFull(eventId)}.json';

    try {
      final responseGet = await http.get(Uri.parse(firebaseUrl));
      if (responseGet.statusCode != 200 || responseGet.body == 'null') {
        throw Exception('Evento não encontrado para exclusão!');
      }

      final response = await http.delete(Uri.parse(firebaseUrl));
      if (response.statusCode != 200) {
        throw Exception('Erro ao remover evento: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao remover evento: $e');
    }
  }

  Future<void> updateEvent(String eventId, Map<String, dynamic> updatedData) async {
    final String firebaseUrl =
        'https://tickets4devs2024-default-rtdb.firebaseio.com/events/${Uri.encodeFull(eventId)}.json';

    try {
      final response = await http.patch(
        Uri.parse(firebaseUrl),
        body: jsonEncode(updatedData),
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar evento: ${response.statusCode}');
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao atualizar evento: $e');
    }
  }
}