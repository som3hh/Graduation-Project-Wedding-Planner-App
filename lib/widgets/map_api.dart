import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng currentLocation = LatLng(30.1191, 31.6053); // Default location

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, handle it accordingly
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, handle it accordingly
      return;
    }

    if (permission == LocationPermission.denied) {
      // Location permissions are denied, request them
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permissions are not granted, handle it accordingly
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    // Use the current location for further operations
  }

  void searchNearbyPlaces(String category) async {
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$category.json?proximity=${currentLocation.longitude},${currentLocation.latitude}&access_token=YOUR_MAPBOX_ACCESS_TOKEN';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle the response data here, such as displaying markers on the map or showing a list of results.
      print(data);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Container(
        height: 850,
        width: 410,
        decoration: BoxDecoration(
            color: const Color(0xffB4E4FF),
            borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(30.1191, 31.6053),
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/som3h/clh701tlo00sa01quhfgohj6a/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29tM2giLCJhIjoiY2xoNno3aDR5MGF4ajNubm9hbXNqdnF3cSJ9.m0qO-8nJmOzD6aqw7OTs8g",
                  additionalOptions: {
                    "access_token":
                        "pk.eyJ1Ijoic29tM2giLCJhIjoiY2xoNno3aDR5MGF4ajNubm9hbXNqdnF3cSJ9.m0qO-8nJmOzD6aqw7OTs8g",
                    "id": "mapbox.mapbox-streets-v8"
                  },
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // code to get current location
              getCurrentLocation();
            },
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              searchNearbyPlaces('beauty_center');
            },
            child: const Icon(Icons.spa),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              searchNearbyPlaces('wedding_dress_shop');
            },
            child: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              searchNearbyPlaces('wedding_hall');
            },
            child: const Icon(Icons.padding),
          ),
        ],
      ),
    );
  }
}
