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
      print(
          "Coordenadas city: $latitude, $longitude"); // Já está imprimindo, mas é bom confirmar
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      print(
          "Placemark retornado: $placemarks"); // Verifique o conteúdo retornado

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String? city = placemark.locality; // Tenta obter a cidade de "locality"

        if (city?.isEmpty ?? true) {
          city =
              placemark.subAdministrativeArea ?? placemark.administrativeArea;
        }

        return city; // Retorna a cidade ou o que for encontrado
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
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      bool permissionGranted = await _checkPermissions();
      if (permissionGranted) {
        final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _currentPosition = location;
        String? newCity =
            await getCityFromCoordinates(location.latitude, location.longitude);

        // Imprima as coordenadas e a cidade atual para diagnóstico
        print("Coordenadas: ${location.latitude}, ${location.longitude}");
        print("Cidade Atual: $newCity");

        // Atualize a cidade apenas se ela for diferente da atual
        if (newCity != currentCity) {
          currentCity = newCity;
        }
        _errorMessage = null;
      } else {
        _errorMessage = "Permissão negada";
        _currentPosition = null;
      }
    } catch (e) {
      _errorMessage = "Erro ao obter localização: $e";
      _currentPosition = null;
    } finally {
      _isLoading = false;
      notifyListeners();
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
