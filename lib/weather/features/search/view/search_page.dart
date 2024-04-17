import 'dart:convert';

import 'package:flutter/material.dart';
//Packages
import 'package:geolocator/geolocator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();
  Position? position;
  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: position == null
                  ? () async {
                      bool serviceEnabled;
                      LocationPermission permission;

                      // Test if location services are enabled.
                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        // Location services are not enabled don't continue
                        // accessing the position and request users of the
                        // App to enable the location services.
                        return Future.error('Location services are disabled.');
                      }

                      permission = await Geolocator.checkPermission();
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied) {
                          // Permissions are denied, next time you could try
                          // requesting permissions again (this is also where
                          // Android's shouldShowRequestPermissionRationale
                          // returned true. According to Android guidelines
                          // your App should show an explanatory UI now.
                          return Future.error(
                              'Location permissions are denied');
                        }
                      }

                      if (permission == LocationPermission.deniedForever) {
                        // Permissions are denied forever, handle appropriately.
                        return Future.error(
                            'Location permissions are permanently denied, we cannot request permissions.');
                      }

                      // When we reach here, permissions are granted and we can
                      // continue accessing the position of the device.
                      final location =
                          position = await Geolocator.getCurrentPosition();
                      setState(() {
                        position = location;
                      });
                    }
                  : null,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, semanticLabel: 'Location'),
                  SizedBox(width: 5),
                  Text("Current Location"),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      hintText: 'Chicago',
                    ),
                  ),
                ),
              ),
              IconButton(
                key: const Key('searchPage_search_iconButton'),
                icon: const Icon(Icons.search, semanticLabel: 'Submit'),
                onPressed: () => Navigator.of(context).pop(jsonEncode({
                  "city": _text,
                  "latitude": position?.latitude,
                  "longitude": position?.longitude
                })),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
