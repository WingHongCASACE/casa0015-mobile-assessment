import 'dart:convert';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shake/shake.dart';
import 'package:ucfnwho_assignment/homePage.dart';

import 'aboutPage.dart';
import 'drawResultPage.dart';
import 'homePage.dart';

final _auth = FirebaseAuth.instance;

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
  static String aName = '';
  static String aVenue = '';
  static num aPrice = 0;
  static num aRating = 0.0;
  static var data;
  bool loadingSpin = false;
  String errorMsg = '';
  late String email;
  late String password;
  bool specifyPlacePress = false;

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
    locateMethodGetCoordinate = false;
    locateMethodSpecifyPlace = false;
    searchAddress = '';
    lat = 0;
    long = 0;
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => homePage()));
          return true;
        },
        child: Scaffold(
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
                colorFilter:
                    ColorFilter.mode(Colors.white54, BlendMode.colorDodge),
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
                      SizedBox(
                        width: 300,
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: TextField(
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
                        ),
                      ),
                      Icons.zoom_in,
                      locateMethodSpecifyPlace != true
                          ? MaterialStateProperty.all(Colors.grey.shade800)
                          : searchAddress.length <= 2 || !specifyPlacePress
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
          drawer: ModalProgressHUD(
            inAsyncCall: loadingSpin,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: _auth.currentUser != null
                              ? Colors.lightGreen[800]
                              : Colors.purple),
                      accountName: Text(
                        "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Container(
                        padding: _auth.currentUser != null
                            ? EdgeInsets.symmetric(horizontal: 60)
                            : EdgeInsets.only(left: 100),
                        child: Text(
                          _auth.currentUser != null
                              ? '${_auth.currentUser?.email}'
                              : 'guest',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      currentAccountPicture: Container(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 94,
                          color: _auth.currentUser != null
                              ? Colors.green[300]
                              : Colors.grey,
                        ),
                      ),
                    ),
                    // const DrawerHeader(
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //   ),
                    //   child: Text('Drawer Header'),
                    // ),
                    Visibility(
                      visible: _auth.currentUser != null ? false : true,
                      child: ListTile(
                        title: const Text('Sign in'),
                        onTap: () {
                          errorMsg = '';
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    // title: Text("Sign in"),
                                    content: StatefulBuilder(
                                      builder: (context, setState) => SizedBox(
                                        height: 270,
                                        child: Column(
                                          children: [
                                            Text('Sign in'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                email = value;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                hintText: "Email address",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextField(
                                              obscureText: true,
                                              onChanged: (value) {
                                                password = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Password",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              errorMsg,
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loadingSpin = true;
                                                  });
                                                  try {
                                                    final newUser = await _auth
                                                        .signInWithEmailAndPassword(
                                                            email: email.trim(),
                                                            password: password
                                                                .trim());
                                                    if (newUser != 'null') {
                                                      print("logined");
                                                      setState(() {
                                                        loadingSpin = false;
                                                      });
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  super
                                                                      .widget));
                                                      Navigator.pop(context);
                                                    }
                                                  } catch (e) {
                                                    loadingSpin = false;
                                                    //Navigator.pop(context);
                                                    setState(() {
                                                      errorMsg =
                                                          'Invalid email or password !';
                                                    });
                                                    print(e);
                                                  }
                                                  // if (_auth.currentUser?.email ==
                                                  //     'null') {
                                                  //   setState(() {
                                                  //     print("failed");
                                                  //     loadingSpin = false;
                                                  //     showDialog(
                                                  //       context: context,
                                                  //       builder: (ctx) => AlertDialog(
                                                  //           title: Text("Error"),
                                                  //           content: Text(
                                                  //               'Log in failed')),
                                                  //     );
                                                  //   });
                                                  // }

                                                  print(email);
                                                  print(password);
                                                  print(
                                                      _auth.currentUser?.email);
                                                },
                                                child: Text('Sign in'))
                                          ],
                                        ),
                                      ),
                                    ),
                                    // actions: [],
                                  ));
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          //Navigator.pop(context);
                        },
                      ),
                    ),
                    Visibility(
                      visible: _auth.currentUser != null ? false : true,
                      child: ListTile(
                        title: const Text('Create account'),
                        onTap: () {
                          errorMsg = '';
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    content: StatefulBuilder(
                                      builder: (context, setState) => SizedBox(
                                        height: 270,
                                        child: Column(
                                          children: [
                                            Text("Register"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (value) {
                                                email = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Email address",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextField(
                                              obscureText: true,
                                              onChanged: (value) {
                                                password = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Password (minimum 6 characters)",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              errorMsg,
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loadingSpin = true;
                                                  });
                                                  try {
                                                    final newUser = await _auth
                                                        .createUserWithEmailAndPassword(
                                                            email: email.trim(),
                                                            password: password
                                                                .trim());
                                                    if (newUser != 'null') {
                                                      print("Account created");
                                                      setState(() {
                                                        loadingSpin = false;
                                                      });
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  super
                                                                      .widget));
                                                      Navigator.pop(context);
                                                    }
                                                  } catch (e) {
                                                    loadingSpin = false;
                                                    //Navigator.pop(context);
                                                    setState(() {
                                                      errorMsg =
                                                          'Invalid email or password !';
                                                    });
                                                    print(e);
                                                  }
                                                  // if (_auth.currentUser?.email ==
                                                  //     'null') {
                                                  //   setState(() {
                                                  //     print("failed");
                                                  //     loadingSpin = false;
                                                  //     showDialog(
                                                  //       context: context,
                                                  //       builder: (ctx) => AlertDialog(
                                                  //           title: Text("Error"),
                                                  //           content: Text(
                                                  //               'Log in failed')),
                                                  //     );
                                                  //   });
                                                  // }

                                                  print(email);
                                                  print(password);
                                                  print(
                                                      _auth.currentUser?.email);
                                                },
                                                child: Text('Register'))
                                          ],
                                        ),
                                      ),
                                    ),
                                    // actions: [],
                                  ));
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Reservation records'),
                      enabled: (_auth.currentUser != null) ? true : false,
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => aboutPage()),
                        );
                      },
                    ),
                    Visibility(
                      visible: _auth.currentUser != null ? true : false,
                      child: ListTile(
                        title: const Text('Sign out'),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          _auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                          print('signed out');
                          print(_auth.authStateChanges());

                          //Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
              color: locateMethodSpecifyPlace == true ||
                      locateMethodGetCoordinate == true
                  ? Colors.blue.withOpacity(0.7)
                  : Colors.grey.shade800,
              height: 100,
              child: SizedBox(
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 30.0),
                  child: AnimatedTextKit(
                    onTap: () async {
                      if (locateMethodSpecifyPlace == true ||
                          locateMethodGetCoordinate == true) {
                        await _fetchData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => drawResultPage(),
                          ),
                        );
                      }
                    },
                    totalRepeatCount: 999,
                    animatedTexts: [
                      RotateAnimatedText('Click here to draw'),
                      RotateAnimatedText('Or Shake the phone'),
                    ],
                  ),
                ),
              )
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //       Colors.blue.withOpacity(0.5),
              //     ),
              //   ),
              //   onPressed: () {
              //     _fetchData();
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         //builder: (context) => drawResultPage(),
              //         builder: (context) => drawResultPage(),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     'Find ',
              //     style: TextStyle(fontSize: 30),
              //   ),
              // ),
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
                      onPressed: () async {
                        if (cardIcon == Icons.map) {
                          setState(() {
                            locateMethodGetCoordinate = true;
                            locateMethodSpecifyPlace = false;
                          });
                          getCoordinate();
                          print('get coordinate works');
                          //await _fetchData();
                        } else if (cardIcon != Icons.map &&
                            searchAddress.length >= 2) {
                          specifyPlacePress = true;
                          setState(() async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            locateMethodGetCoordinate = false;
                            locateMethodSpecifyPlace = true;
                            print(searchAddress);
                            _fetchCoord();
                            //await _fetchData();
                          });
                          // setState(() async {
                          //   List<Location> location =
                          //       await locationFromAddress(searchAddress);
                          //   print(location);
                          // });

                        } else {
                          setState(() async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            locateMethodGetCoordinate = false;
                            locateMethodSpecifyPlace = false;
                          });
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

  Future<void> getCoordinate() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    print('latitude is:$lat longitude:$long');
    print(lat);
    print(long);
  }

  Future<void> _fetchCoord() async {
    //const API_URL = 'https://jsonplaceholder.typicode.com/photos';
    String API_URL =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${searchAddress.replaceAll(RegExp(' '), "+")}&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.421998333333335%2C-122.084&radius=200&type=dissert&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);
    lat = data["results"][0]['geometry']['location']['lat'];
    long = data["results"][0]['geometry']['location']['lng'];

    setState(() {
      print(response);
      print(data);
      print(lat);
      print(long);
    });
  }

  Future<void> _fetchData() async {
    //const API_URL = 'https://jsonplaceholder.typicode.com/photos';
    String API_URL =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%2C${long}&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.4219%2C-122.084&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.86605%2C151.1957362&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    final response = await http.get(Uri.parse(API_URL));
    data = json.decode(response.body);
    print(response);
    print(data);
    final datadraw = data["results"][Random().nextInt(data.length)];
    aName = datadraw["name"];
    print(aName);
    aVenue = datadraw["vicinity"];
    aPrice = datadraw["price_level"];
    aPrice = datadraw["price_level"];
    aRating = datadraw["rating"];
  }
}
