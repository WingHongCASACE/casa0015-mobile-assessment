import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestLocation(),
    );
  }
}

class TestLocation extends StatefulWidget {
  @override
  _TestLocationState createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  //late ShakeDetector detector;
  int shakeCount = 0;

  @override
  void initState() {
    super.initState();
    //TODO check if it is needed to create a detector
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

  void getCoordinate() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;
    print('latitude is:$lat longitude:$long');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              getCoordinate();
              print('recorded coordinate');
              //shake();
            },
            child: const Text('get coordinate'),
          ),
          Text(
            shakeCount.toString(),
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    ));
  }
}
