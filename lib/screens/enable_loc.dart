import 'dart:convert';
<<<<<<< HEAD
import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'homescreen.dart'; 
import 'user_session.dart'; 

=======
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'homescreen.dart'; // Ensure this file exists
import 'user_session.dart'; 


// =========================================================
// 2. ENABLE LOCATION SCREEN
// =========================================================
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({super.key});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  bool _isLoading = false;
<<<<<<< HEAD
  String _statusMessage = 'Allow location access to continue using the app.';

  // API Call to update location on server
  Future<void> _updateLocationOnServer(double lat, double lng) async {
    final url = Uri.parse("https://mechanicapp-service-621632382478.asia-south1.run.app/api/current/location");
=======

  // API Call to update location on server
  Future<void> _updateLocationOnServer(double lat, double lng) async {
    final url = Uri.parse("https://mechanicapp-service-621632382478.asia-south1.run.app/api/current/location" );
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39

    try {
      final response = await http.post(
        url,
<<<<<<< HEAD
        headers: UserSession().getAuthHeader(), 
=======
        headers: UserSession( ).getAuthHeader(), // Using stored credentials
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
        body: jsonEncode({
          "latitude": lat,
          "longitude": lng,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Location updated on server");
      } else {
<<<<<<< HEAD
        debugPrint("❌ Server Error: ${response.statusCode}");
=======
        debugPrint("❌ Server Error: ${response.statusCode} - ${response.body}");
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      }
    } catch (e) {
      debugPrint("❌ Network Error: $e");
    }
  }

  Future<void> handleLocationPermission() async {
<<<<<<< HEAD
    setState(() {
      _isLoading = true;
      _statusMessage = "Checking permissions...";
    });

    try {
      // 1. Service check
=======
    setState(() => _isLoading = true);

    try {
      // Check if location services are enabled
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        setState(() => _isLoading = false);
        return;
      }

<<<<<<< HEAD
      // 2. Permission check
=======
      // Check and Request Permissions
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar("Location permission denied");
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
<<<<<<< HEAD
        _showSnackBar("Permissions permanently denied");
=======
        _showSnackBar("Location permissions are permanently denied");
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
        setState(() => _isLoading = false);
        return;
      }

<<<<<<< HEAD
      // 3. Accuracy Filter Logic
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position? bestPosition;
        int attempts = 0;
        const int maxAttempts = 5; // 5 baar koshish karega behtar accuracy ke liye

        AndroidSettings androidSettings = AndroidSettings(
          accuracy: LocationAccuracy.best,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 2),
        );

        while (attempts < maxAttempts) {
          attempts++;
          setState(() => _statusMessage = "Refining location... Attempt $attempts");

          Position currentPos = await Geolocator.getCurrentPosition(
            locationSettings: androidSettings,
          );

          debugPrint("Current Accuracy: ${currentPos.accuracy} meters");

          // Agar accuracy 20 meter se behtar hai toh loop break kar dein
          if (currentPos.accuracy <= 20) {
            bestPosition = currentPos;  
            break; 
          } else {
            // Agar accuracy achi nahi hai toh thora wait karke dobara check karein
            bestPosition = currentPos; // Phir bhi save karlein in case loop khatam ho jaye
            await Future.delayed(const Duration(seconds: 2));
          }
        }

        if (bestPosition != null) {
          setState(() => _statusMessage = "Sending precise location...");
          await _updateLocationOnServer(bestPosition.latitude, bestPosition.longitude);
          
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      _showSnackBar("Error: $e");
=======
      // If permission granted, get position and call API
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Send to API
        await _updateLocationOnServer(position.latitude, position.longitude);

        if (!mounted) return;

        // Navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      _showSnackBar("An error occurred: $e");
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
<<<<<<< HEAD
              const Icon(Icons.location_on_rounded, size: 90, color: Color(0xFFFB3300)),
              const SizedBox(height: 20),
              const Text('Enable Location', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Text(_statusMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Colors.black54)),
=======
              const Icon(
                Icons.location_on_rounded,
                size: 90,
                color: Color(0xFFFB3300),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enable Location',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Text(
                'Allow location access to continue using the app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : handleLocationPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB3300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
<<<<<<< HEAD
                      : const Text('Allow', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
=======
                      : const Text(
                          'Allow',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
} 
=======
}
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
