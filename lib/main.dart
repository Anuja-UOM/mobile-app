import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with proper options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
    // Continue without Firebase for demo purposes
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker PWA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        // PWA-optimized theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LocationTrackerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationTrackerPage extends StatefulWidget {
  const LocationTrackerPage({super.key});

  @override
  State<LocationTrackerPage> createState() => _LocationTrackerPageState();
}

class _LocationTrackerPageState extends State<LocationTrackerPage> {
  Position? _currentPosition;
  bool _isTracking = false;
  bool _permissionGranted = false;
  String _statusMessage = 'Tap to start location tracking';
  Timer? _locationTimer;
  FirebaseFirestore? _firestore;
  String? _deviceId;
  bool _isPWA = false;

  @override
  void initState() {
    super.initState();
    _detectPWA();
    _initializeApp();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    super.dispose();
  }

  void _detectPWA() {
    // Detect if running as PWA
    _isPWA = kIsWeb;
    if (_isPWA) {
      print('Running as Progressive Web App');
    }
  }

  Future<void> _initializeApp() async {
    _deviceId = _generateDeviceId();

    // Check if Firebase is available
    try {
      _firestore = FirebaseFirestore.instance;
      print('Firestore connection established');
    } catch (e) {
      print('Firestore not available: $e');
    }

    await _checkPermissions();
  }

  String _generateDeviceId() {
    // Simple device ID generation - use device_info_plus for production
    return 'device_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _statusMessage = 'Location services are disabled';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _statusMessage = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _statusMessage = 'Location permissions are permanently denied';
      });
      return;
    }

    setState(() {
      _permissionGranted = true;
      _statusMessage = 'Ready to track location';
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      await _saveLocationToFirestore(position);
    } catch (e) {
      setState(() {
        _statusMessage = 'Error getting location: $e';
      });
    }
  }

  Future<void> _saveLocationToFirestore(Position position) async {
    if (_firestore == null) {
      setState(() {
        _statusMessage = 'Location updated (Firebase not configured)';
      });
      return;
    }

    try {
      await _firestore!.collection('locations').doc(_deviceId).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'timestamp': FieldValue.serverTimestamp(),
        'altitude': position.altitude,
        'speed': position.speed,
      }, SetOptions(merge: true));

      setState(() {
        _statusMessage = 'Location saved to Firebase successfully';
      });
    } catch (e) {
      setState(() {
        _statusMessage =
            'Location updated (Firebase error: ${e.toString().split(']').last})';
      });
    }
  }

  void _startTracking() {
    if (!_permissionGranted) {
      _checkPermissions();
      return;
    }

    setState(() {
      _isTracking = true;
      _statusMessage = 'Tracking location...';
    });

    // Get initial location
    _getCurrentLocation();

    // Set up periodic location updates
    _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  void _stopTracking() {
    _locationTimer?.cancel();
    setState(() {
      _isTracking = false;
      _statusMessage = 'Location tracking stopped';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Text(
                  'Location Tracker',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Status Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          _isTracking ? Icons.location_on : Icons.location_off,
                          size: 48,
                          color: _isTracking ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _statusMessage,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        // Firebase Status Indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _firestore != null
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _firestore != null
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _firestore != null
                                    ? Icons.cloud_done
                                    : Icons.cloud_off,
                                size: 16,
                                color: _firestore != null
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _firestore != null
                                    ? 'Firebase Connected'
                                    : 'Firebase Offline',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _firestore != null
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // PWA Status Indicator
                        if (_isPWA)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.web,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Progressive Web App',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Location Information Card
                if (_currentPosition != null)
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildLocationRow(
                            Icons.my_location,
                            'Latitude',
                            '${_currentPosition!.latitude.toStringAsFixed(6)}°',
                          ),
                          const SizedBox(height: 8),
                          _buildLocationRow(
                            Icons.location_on,
                            'Longitude',
                            '${_currentPosition!.longitude.toStringAsFixed(6)}°',
                          ),
                          const SizedBox(height: 8),
                          _buildLocationRow(
                            Icons.speed,
                            'Accuracy',
                            '${_currentPosition!.accuracy.toStringAsFixed(1)}m',
                          ),
                          const SizedBox(height: 8),
                          _buildLocationRow(
                            Icons.access_time,
                            'Last Updated',
                            '${DateTime.now().toLocal().toString().split('.')[0]}',
                          ),
                        ],
                      ),
                    ),
                  ),

                const Spacer(),

                // Control Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isTracking ? _stopTracking : _startTracking,
                        icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
                        label: Text(
                          _isTracking ? 'Stop Tracking' : 'Start Tracking',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isTracking
                              ? Colors.red
                              : Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _permissionGranted
                      ? _getCurrentLocation
                      : _checkPermissions,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
