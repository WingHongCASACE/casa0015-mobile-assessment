import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shake/shake.dart';

import 'drawResultPage.dart';

class locatePage extends StatefulWidget {
  const locatePage({Key? key}) : super(key: key);

  @override
  State<locatePage> createState() => locatePageState();
}

class locatePageState extends State<locatePage> {
  @override
  static double lat = 0;
  static double long = 0;
  int shakeCount = 0;
  late String searchAddress;
  bool locateMethodGetCoordinate = false;
  bool locateMethodSpecifyPlace = false;

  void getLat() {
    lat;
  }

  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        print('I\'m shaking');
        shakeCount++;
      });
      //bool isShake = true;

      // Do stuff on phone shake
    });
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        //shadowColor: Colors.yellow,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.white54, BlendMode.colorDodge),
            image: AssetImage(
                'images/house-g219df3e8a_1920-locatePage-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100.0,
            left: 30.0,
            right: 30.0,
            bottom: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              locatePageCard(
                  Text("Use Current Location"),
                  Icons.map,
                  locateMethodGetCoordinate != true
                      ? MaterialStateProperty.all(Colors.grey.shade800)
                      : MaterialStateProperty.all(Colors.green),
                  'get coordinate'),
              const Divider(
                height: 50,
                thickness: 5,
                indent: 20,
                endIndent: 20,
                color: Colors.black45,
              ),
              locatePageCard(
                  TextField(
                    onChanged: (value) {
                      searchAddress = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Street/Borough/City",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Icons.zoom_in,
                  locateMethodSpecifyPlace != true
                      ? MaterialStateProperty.all(Colors.grey.shade800)
                      : MaterialStateProperty.all(Colors.green),
                  'specify place'),
              SizedBox(height: 24),
              // Text(
              //   shakeCount.toString(),
              //   style: TextStyle(fontSize: 24),
              // ),
              SizedBox(height: 24),
              // ElevatedButton(
              //   onPressed: () {
              //     MapsLauncher.launchCoordinates(lat, long);
              //   },
              //   child: const Text('View on map'),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blue.withOpacity(0.5),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => drawResultPage(),
              ),
            );
          },
          child: Text(
            'Find ',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }

  Container locatePageCard(cardLeft, cardIcon, iconColorState, cardIconText) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(6.0),
              child: Center(child: cardLeft),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 140,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: iconColorState,
                      ),
                      onPressed: () {
                        if (cardIcon == Icons.map) {
                          setState(() {
                            locateMethodGetCoordinate = true;
                            locateMethodSpecifyPlace = false;
                          });
                          //_getSearchCoordinate();
                          print('get coordinate works');
                        } else {
                          setState(() {
                            locateMethodGetCoordinate = false;
                            locateMethodSpecifyPlace = true;
                            print(searchAddress);
                            _fetchCoord();
                          });
                          // setState(() async {
                          //   List<Location> location =
                          //       await locationFromAddress(searchAddress);
                          //   print(location);
                          // });
                        }
                        //shake();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cardIcon,
                            size: 48,
                          ),
                          Text(cardIconText),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _getSearchCoordinate() async {
  //   GeoCode geoCode = GeoCode();
  //   try {
  //     Coordinates coordinates =
  //         await geoCode.forwardGeocoding(address: searchAddress);
  //     print("Latitude: ${coordinates.latitude}");
  //     print("Longitude: ${coordinates.longitude}");
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   setState(() {});
  // }

  void getCoordinate() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    print('latitude is:$lat longitude:$long');
  }

  Future<void> _fetchCoord() async {
    //const API_URL = 'https://jsonplaceholder.typicode.com/photos';
    String API_URL =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${searchAddress.replaceAll(RegExp(' '), "+")}&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';

    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);
    lat = data["results"][0]['geometry']['location']['lat'];
    long = data["results"][0]['geometry']['location']['lng'];

    setState(() {
      print(response);
      print(data);
    });
  }
}
