import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationNotifier extends ChangeNotifier {
  Position? _currentPosition;
  String? _errorMessage;
  bool _isLoading = false;
  String? currentCity;

  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  LocationNotifier() {
    fetchLocation(); // Chama a função de localização ao inicializar
  }

  Future<String?> getCityFromCoordinates(
      double latitude, double longitude) async {
    try {
      // Obtém o endereço completo da latitude e longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Verifica se obteve algum resultado
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.locality; // Retorna a cidade
      } else {
        return null; // Caso não encontre a cidade
      }
    } catch (e) {
      print("Erro ao obter a cidade: $e");
      return null;
    }
  }

  // Método para atualizar a localização
  Future<void> fetchLocation() async {
    if (_isLoading)
      return; // Impede chamadas repetidas se já estiver carregando

    try {
      _isLoading = true;
      notifyListeners(); // Notifica para atualizar a UI e mostrar o carregamento

      // A lógica para obter permissão e localização vai aqui
      bool permissionGranted = await _checkPermissions();
      if (permissionGranted) {
        final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _currentPosition = location;
        currentCity = await getCityFromCoordinates(
            location.latitude, location.longitude); // Obtém a cidade
        print("currentcity $currentCity");
        _errorMessage = null; // Limpa qualquer mensagem de erro
      } else {
        _errorMessage =
            "Permissão negada"; // Define erro caso a permissão seja negada
        _currentPosition = null;
      }
    } catch (e) {
      _errorMessage =
          "Erro ao obter localização: $e"; // Define o erro caso ocorra alguma falha
      _currentPosition = null;
    } finally {
      _isLoading = false; // Marca como não carregando
      notifyListeners(); // Notifica para atualizar a UI
    }
  }

  // Verifica permissões de localização
  Future<bool> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}
