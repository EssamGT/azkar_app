import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Fetches the current location (latitude & longitude)
Future<Position> getLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    // Always fetch a fresh location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } catch (e) {
    throw Exception("Error getting location: $e");
  }
}
/// Fetches the user's address from their current location
Future<void> getUserAddress() async {
  try {
    Position position = await getLocation(); // Get location
    String address = await getAddressFromLatLng(
      position.latitude,
      position.longitude,
    );
    print('User Address: $address');
  } catch (e) {
    print('Error: $e');
  }
}

/// Converts latitude & longitude into a human-readable address
Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }
    return "No address found";
  } catch (e) {
    return "Error: $e";
  }
}

/// Fetches only the user's country from their location
Future<String> getCountryFromLocation() async {
  try {
    Position position = await getLocation(); // Get location
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks.first.country ?? 'Country not found';
    }
    return 'No country found';
  } catch (e) {
    return "Error: $e";
  }
}



Future<String> getAddressInArabic(double latitude, double longitude) async {
  try {
    // Get the placemarks using the device's locale
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      return " ${place.locality}";
    }
    return "No address found";
  } catch (e) {
    return "Error: $e";
  }
}
