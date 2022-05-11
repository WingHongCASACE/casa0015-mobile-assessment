import 'dart:convert';
import 'dart:math';

//import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';

import 'locatePage.dart';

class drawResultPage extends StatefulWidget {
  @override
  _drawResultPageState createState() => _drawResultPageState();
}

class _drawResultPageState extends State<drawResultPage> {
  // The list that contains information about photos
  List _loadedPhotos = [];
  String aName = "";
  String aVenue = "";
  int aPrice = 0;
  double aRating = 0.0;
  double lat = locatePageState.lat;
  double long = locatePageState.long;

  bool loading = true;

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    //const API_URL = 'https://jsonplaceholder.typicode.com/photos';
    String API_URL =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%2C${long}&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.4219%2C-122.084&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.86605%2C151.1957362&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);
    final datadraw = await data["results"][Random().nextInt(data.length)];

    print(response);
    print(data);
    print(datadraw);

    aName = datadraw["name"];
    aVenue = datadraw["vicinity"];
    aPrice = datadraw["price_level"];
    aRating = datadraw["rating"];

    setState(() {
      //_loadedPhotos = data;
      //photoscom = data.shuffle();
      print(datadraw["name"]);
      print(datadraw["price_level"]);
      print(datadraw["rating"]);
      print(datadraw["vicinity"]);
      print(datadraw);
    });
  }

  CuisineSupport cuisineSupport = CuisineSupport();
  FoodQuote foodQuote = FoodQuote();

  //TODO add transition to allow loading
  // void initState() {
  //   super.initState();
  //   _fetchData();
  // }
  //bool isShake = true;
  // Do stuff on phone shake

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.white54, BlendMode.colorDodge),
              image: AssetImage(
                  'images/bistro-gfe17ee854_1280-drawResultPage-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Text('Load Photos'),
                      onPressed: () {
                        _fetchData();
                        //print(lat);
                      }),
                  ElevatedButton(
                    child: Text('Load Cuisine'),
                    onPressed: () async {
                      setState(() {
                        loading = false;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {
                        cuisineSupport.genNum();
                        loading = true;
                        print(cuisineSupport.randomNum);
                        print(cuisineSupport
                            ._cuisine[cuisineSupport.randomNum].cuisineIMG);
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  loading
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 650,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(cuisineSupport
                                          ._cuisine[cuisineSupport.randomNum]
                                          .cuisineIMG),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50),
                                        bottom: Radius.zero),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 600, end: 5),
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        side: MaterialStateProperty.all(
                                          BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        )),
                                    onPressed: () {
                                      print('${lat},${long}');
                                      MapsLauncher.launchCoordinates(lat, long);
                                    },
                                    child: (Wrap(
                                      children: [
                                        Text(
                                          'Show location',
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.map,
                                          size: 20,
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 610, start: 5),
                                  child: Text(
                                    '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ]),
                              // child: Image.asset(cuisineSupport
                              //     ._cuisine[cuisineSupport.randomNum].cuisineIMG),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent[200],
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.zero,
                                        bottom: Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: restaurantCard(
                                      //cuisineSupport: cuisineSupport,
                                      aName: aName,
                                      aPrice: aPrice,
                                      aRating: aRating,
                                      aVenue: aVenue),
                                  // child: Text(
                                  //   '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine\n\n'
                                  //   '${aName}\n\nPrice level: ${aPrice.toString()}         Rating: ${aRating.toString()}\n\n${aVenue}',
                                  //   style: TextStyle(
                                  //     fontSize: 24,
                                  //     color: Colors.white,
                                  //   ),
                                ),
                              ),
                            ),
                            //),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: 250),
                            Container(
                              child: const CircularProgressIndicator(),
                            ),
                            SizedBox(height: 250),
                            Text(
                                '${foodQuote._foodquote[foodQuote.randomNum].quote}'),
                            Text(
                                '${foodQuote._foodquote[foodQuote.randomNum].quoteFrom}'),
                            SizedBox(height: 250),
                          ],
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print('${lat},${long}');
                  //     MapsLauncher.launchCoordinates(lat, long);
                  //   },
                  //   child: (Wrap(
                  //     children: [
                  //       Text(
                  //         'Show location',
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Icon(
                  //         Icons.map,
                  //         size: 20,
                  //       ),
                  //     ],
                  //   )),
                  // ),
                  // ElevatedButton(
                  //   onPressed: _fetchData,
                  //   child: (Wrap(
                  //     children: [
                  //       Text(
                  //         'Draw again',
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Icon(
                  //         Icons.autorenew,
                  //         size: 20,
                  //       ),
                  //     ],
                  //   )),
                  // ),
                  // ElevatedButton(
                  //   onPressed: _fetchData,
                  //   child: (Wrap(
                  //     children: [
                  //       Text(
                  //         'Reserve',
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Icon(
                  //         Icons.book,
                  //         size: 20,
                  //       ),
                  //     ],
                  //   )),
                  // ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.redAccent.withOpacity(0.6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //builder: (context) => drawResultPage(),
                        builder: (context) => drawResultPage(),
                      ),
                    );
                  },
                  child: Wrap(spacing: 10, children: [
                    Icon(
                      Icons.swap_horiz,
                      size: 30,
                    ),
                    Text(
                      'Draw Again',
                      style: TextStyle(fontSize: 30),
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green.withOpacity(0.6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //builder: (context) => drawResultPage(),
                        builder: (context) => drawResultPage(),
                      ),
                    );
                  },
                  child: Wrap(spacing: 10, children: [
                    Icon(
                      Icons.calendar_today,
                      size: 30,
                    ),
                    Text(
                      'Reserve',
                      style: TextStyle(fontSize: 30),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class restaurantCard extends StatelessWidget {
  const restaurantCard({
    Key? key,
    //required this.cuisineSupport,
    required this.aName,
    required this.aPrice,
    required this.aRating,
    required this.aVenue,
  }) : super(key: key);

  //final CuisineSupport cuisineSupport;
  final String aName;
  final int aPrice;
  final double aRating;
  final String aVenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //     '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 22,
        //     ),
        //   ),
        // ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${aName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Price level: ${aPrice.toString()} / 5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Rating: ${aRating.toString()} / 5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${aVenue}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}

class CuisineA {
  late String cuisine;
  late String cuisineIMG;

  CuisineA(String a, String b) {
    cuisine = a;
    cuisineIMG = b;
  }
}

class CuisineSupport {
  int randomNum = 0;

  //final String cuisine;
  //final String cuisineIMG;

  //CuisineSupport({required this.cuisine, required this.cuisineIMG});

  List<CuisineA> _cuisine = [
    CuisineA("Mexican", "images/taco-g68fb49a04_1280-mexican.jpg"),
    CuisineA("Swedish", "images/toast-skagen-g20d6e797f_1280-swedish.jpg"),
    CuisineA("Italian", "images/pizza-g9edef2467_1280-italian.jpg"),
    CuisineA("Spanish", "images/paella-g495d6e653_1280-spanish.jpg"),
    CuisineA("America", "images/hamburger-ga3f78a511_640-american.jpg"),
    CuisineA("British", "images/food-g34fd8a3b8_1280-british.jpg"),
    CuisineA("Thai", "images/fish-g33be0ef20_1280-thai.jpg"),
    CuisineA("Japanese", "images/sushi-g37aaa190d_1280-japanese.jpg"),
    CuisineA("Chinese", "images/dim-sum-g9d5f56483_1280-chinese.jpg"),
    CuisineA("Indian", "images/indian-food-g6c052f420_1280-indian.jpg"),
    CuisineA("French", "images/quiche-ga9a0acea2_1280-french.jpg"),
    CuisineA("Greek", "images/hummus-g95f7428ed_1280-greek.jpg"),
    CuisineA("Korean", "images/alum-gf52e26a7b_1280-korean.jpg"),
    CuisineA(
        "Turkish", "images/middle-eastern-food-gb320d4da1_1280-turkish.jpg"),
  ];

  void genNum() {
    randomNum = Random().nextInt(_cuisine.length);
  }

  String cuisineName() {
    return _cuisine[randomNum].cuisine;
  }

  String cuisineImg() {
    return _cuisine[randomNum].cuisineIMG;
  }
}

class foodQuoteA {
  late String quote;
  late String quoteFrom;

  foodQuoteA(String a, String b) {
    quote = a;
    quoteFrom = b;
  }
}

class FoodQuote {
  int randomNum = 0;

  List<foodQuoteA> _foodquote = [
    //https://www.delish.com/food/g25438962/food-quotes/?slide=21
    foodQuoteA(
        "All happiness depends on a leisurely breakfast.", "John Gunther"),
    foodQuoteA(
        "You don't need a silver fork to eat good food.", "Paul Prudhomme"),
    foodQuoteA(
        "I only drink Champagne on two occasions, when I am in love and when I am not.",
        "Coco Chanel"),
    foodQuoteA("A balanced diet is a cookie in each hand.", "Barbara Johnson"),
    foodQuoteA(
        "Cooking is like love. It should be entered into with abandon or not at all.",
        "Harriet Van Horne"),
    foodQuoteA(
        "People who love to eat are always the best people.", "Julia Child"),
    foodQuoteA("To eat is a necessity, but to eat intelligently is an art.",
        "François de la Rochefoucauld"),
    foodQuoteA(
        "We all eat, an it would be a sad waste of opportunity to eat badly.",
        "Anna Thomas"),
    foodQuoteA(
        "If you really want to make a friend, go to someone's house and eat with him...the people who give you their food give you their heart.",
        "Cesar Chavez"),
    foodQuoteA(
        "Always serve too much hot fudge sauce on hot fudge sundaes. It makes people overjoyed and puts them in your debt.",
        "Judith Olney"),
    foodQuoteA(
        "Ice cream is exquisite. What a pity it isn't illegal.", "Voltaire"),
    foodQuoteA(
        "Cooking is all about people. Food is maybe the only universal thing that really has the power to bring everyone together. No matter what culture, everywhere around the world, people eat together.",
        "Guy Fieri"),
    foodQuoteA(
        "The only time to eat diet food is while you're waiting for the steak to cook.",
        "Julia Child"),
    foodQuoteA("Laughter is brightest where food is best.", "Irish Proverb"),
    foodQuoteA("Life is a combination of magic and pasta.", "Federico Fellini"),
    foodQuoteA(
        "It's difficult to think anything but pleasant thoughts while eating a homegrown tomato.",
        "Lewis Grizzard"),
    foodQuoteA(
        "One cannot think well, love well, sleep well, if not has not dined well.",
        "Virginia Woolf"),
    foodQuoteA("Everything you see, I owe to spaghetti.", "Sophia Loren"),
    foodQuoteA("Age and glasses of wine should never be counted.", "Unknown"),
    foodQuoteA("I cook with wine. Sometimes I even add it to the food.",
        "W.C. Fields"),
  ];

  void genNum() {
    randomNum = Random().nextInt(_foodquote.length);
  }
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TestLocation(),
//     );
//   }
// }
//
// class TestLocation extends StatefulWidget {
//   @override
//   _TestLocationState createState() => _TestLocationState();
// }
//
// class _TestLocationState extends State<TestLocation> {
//   //late ShakeDetector detector;
//   int shakeCount = 0;
//
//   @override
//   double lat = 0;
//   double long = 0;
//
//   List _loadedPhotos = [];
//   Future<void> _fetchData() async {
//     const API_URL = 'https://jsonplaceholder.typicode.com/photos';
//
//     final response = await http.get(Uri.parse(API_URL));
//     final data = json.decode(response.body);
//
//     setState(() {
//       _loadedPhotos = data;
//     });
//   }
//   //late Future<Album> futureAlbum;
//
//   void initState() {
//     super.initState();
//     //futureAlbum = fetchAlbum();
//     //TODO check if it is needed to create a detector
//     ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
//       setState(() {
//         print('I\'m shaking');
//         shakeCount++;
//       });
//       //bool isShake = true;
//
//       // Do stuff on phone shake
//     });
//     ;
//   }
//
//   void getCoordinate() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     lat = position.latitude;
//     long = position.longitude;
//     print('latitude is:$lat longitude:$long');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Center(
//         child: Column(children: [
//           ElevatedButton(
//             onPressed: () {
//               getCoordinate();
//               print('recorded coordinate');
//               //shake();
//             },
//             child: const Text('get coordinate'),
//           ),
//           SizedBox(height: 24),
//           Text(
//             shakeCount.toString(),
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {
//               MapsLauncher.launchCoordinates(lat, long);
//             },
//             child: const Text('View on map'),
//           ),
//           // Center(
//           //   child: FutureBuilder<Album>(
//           //     future: futureAlbum,
//           //     builder: (context, snapshot) {
//           //       if (snapshot.hasData) {
//           //         //return Text(snapshot.data!.id.toString()),
//           //         print(snapshot.data!.id.toString());
//           //       } else if (snapshot.hasError) {
//           //         return Text('${snapshot.error}');
//           //       }
//           //
//           //       // By default, show a loading spinner.
//           //       return const CircularProgressIndicator();
//           //     },
//           //   ),
//           // ),
//           Container(
//             child: _loadedPhotos.length == 0
//                 ? Center(
//                     child: ElevatedButton(
//                       child: Text('Load Photos'),
//                       onPressed: _fetchData,
//                     ),
//                   )
//                 // The ListView that displays photos
//                 : ListView.builder(
//                     itemCount: _loadedPhotos.length,
//                     itemBuilder: (BuildContext ctx, index) {
//                       return ListTile(
//                         leading: Image.network(
//                           _loadedPhotos[index]["thumbnailUrl"],
//                           width: 150,
//                           fit: BoxFit.cover,
//                         ),
//                         title: Text(_loadedPhotos[index]['title']),
//                         subtitle:
//                             Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
//                       );
//                     },
//                   ),
//           ),
//         ]),
//       )),
//     );
//   }
// }

// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   int userId;
//   int id;
//   String title;
//
//   Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

/*// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Hide the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Essen wo bitter',
//       home: HomePage(),
//     );
//   }
// }

class drawResultPage extends StatefulWidget {
  @override
  _drawResultPageState createState() => _drawResultPageState();
}

class _drawResultPageState extends State<drawResultPage> {
  // The list that contains information about photos
  List _loadedPhotos = [];
  String aName = "";
  String aVenue = "";
  int aPrice = 0;
  double aRating = 0.0;
  bool loading = true;
  double lat = locatePageState.lat;
  double long = locatePageState.long;

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    //const API_URL = 'https://jsonplaceholder.typicode.com/photos';
    String API_URL =
        //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%2C${long}&radius=200&type=restaurant&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.421998333333335%2C-122.084&radius=200&type=dissert&key=AIzaSyAt8mEWR3AvpdXpaRE7yWSwE_dRS9VKg4Y';
    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);
    final datadraw = data["results"][Random().nextInt(data.length)];

    aName = datadraw["name"];
    aVenue = datadraw["vicinity"];
    aPrice = datadraw["price_level"];
    aRating = datadraw["rating"];

    setState(() {
      //_loadedPhotos = data;
      //photoscom = data.shuffle();
      print(datadraw["name"]);
      print(datadraw["price_level"]);
      print(datadraw["rating"]);
      print(datadraw["vicinity"]);
      print(datadraw);
    });
  }

  CuisineSupport cuisineSupport = CuisineSupport();
  FoodQuote foodQuote = FoodQuote();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''), backgroundColor: Colors.blue,
          //shadowColor: Colors.yellow,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              image: AssetImage(
                  'images/bistro-gfe17ee854_1280-drawResultPage-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Load Photos'),
                    onPressed: _fetchData,
                  ),
                  ElevatedButton(
                    child: Text('Load Cuisine'),
                    onPressed: () async {
                      setState(() {
                        loading = false;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {
                        cuisineSupport.genNum();
                        loading = true;
                        print(cuisineSupport.randomNum);
                        print(cuisineSupport
                            ._cuisine[cuisineSupport.randomNum].cuisineIMG);
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  loading
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 700,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(cuisineSupport
                                          ._cuisine[cuisineSupport.randomNum]
                                          .cuisineIMG),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50),
                                        bottom: Radius.zero),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 650, end: 5),
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        side: MaterialStateProperty.all(
                                          BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        )),
                                    onPressed: () {
                                      print('${lat},${long}');
                                      MapsLauncher.launchCoordinates(lat, long);
                                    },
                                    child: (Wrap(
                                      children: [
                                        Text(
                                          'Show location',
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.map,
                                          size: 20,
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 660, start: 5),
                                  child: Text(
                                    '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ]),
                              // child: Image.asset(cuisineSupport
                              //     ._cuisine[cuisineSupport.randomNum].cuisineIMG),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent[200],
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.zero,
                                        bottom: Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: restaurantCard(
                                      //cuisineSupport: cuisineSupport,
                                      aName: aName,
                                      aPrice: aPrice,
                                      aRating: aRating,
                                      aVenue: aVenue),
                                  // child: Text(
                                  //   '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine\n\n'
                                  //   '${aName}\n\nPrice level: ${aPrice.toString()}         Rating: ${aRating.toString()}\n\n${aVenue}',
                                  //   style: TextStyle(
                                  //     fontSize: 24,
                                  //     color: Colors.white,
                                  //   ),
                                ),
                              ),
                            ),
                            //),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: 250),
                            Container(
                              child: const CircularProgressIndicator(),
                            ),
                            SizedBox(height: 250),
                            Text(
                                '${foodQuote._foodquote[foodQuote.randomNum].quote}'),
                            Text(
                                '${foodQuote._foodquote[foodQuote.randomNum].quoteFrom}'),
                            SizedBox(height: 250),
                          ],
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print('${lat},${long}');
                  //     MapsLauncher.launchCoordinates(lat, long);
                  //   },
                  //   child: (Wrap(
                  //     children: [
                  //       Text(
                  //         'Show location',
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Icon(
                  //         Icons.map,
                  //         size: 20,
                  //       ),
                  //     ],
                  //   )),
                  // ),
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: (Wrap(
                      children: [
                        Text(
                          'Draw again',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.autorenew,
                          size: 20,
                        ),
                      ],
                    )),
                  ),
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: (Wrap(
                      children: [
                        Text(
                          'Reserve',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.book,
                          size: 20,
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
        /*SafeArea(
              child: _loadedPhotos.length == 0
                  ? Center(
                      child: ElevatedButton(
                        child: Text('Load Photos'),
                        onPressed: _fetchData,
                      ),
                    )
                  // The ListView that displays photos
                  : ListView.builder(
                      itemCount: _loadedPhotos.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ListTile(
                          leading: Image.network(
                            _loadedPhotos[index]["thumbnailUrl"],
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          title: Text(_loadedPhotos[index]['title']),
                          subtitle:
                              Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
                        );
                      },
                    ))*/
      ),
    );
  }
}

class restaurantCard extends StatelessWidget {
  const restaurantCard({
    Key? key,
    //required this.cuisineSupport,
    required this.aName,
    required this.aPrice,
    required this.aRating,
    required this.aVenue,
  }) : super(key: key);

  //final CuisineSupport cuisineSupport;
  final String aName;
  final int aPrice;
  final double aRating;
  final String aVenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //     '${cuisineSupport._cuisine[cuisineSupport.randomNum].cuisine}\ cuisine',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 22,
        //     ),
        //   ),
        // ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${aName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Price level: ${aPrice.toString()} / 5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Rating: ${aRating.toString()} / 5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${aVenue}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}

class CuisineA {
  late String cuisine;
  late String cuisineIMG;

  CuisineA(String a, String b) {
    cuisine = a;
    cuisineIMG = b;
  }
}

class CuisineSupport {
  int randomNum = 0;

  //final String cuisine;
  //final String cuisineIMG;

  //CuisineSupport({required this.cuisine, required this.cuisineIMG});

  List<CuisineA> _cuisine = [
    CuisineA("Mexican", "images/taco-g68fb49a04_1280-mexican.jpg"),
    CuisineA("Swedish", "images/toast-skagen-g20d6e797f_1280-swedish.jpg"),
    CuisineA("Italian", "images/pizza-g9edef2467_1280-italian.jpg"),
    CuisineA("Spanish", "images/paella-g495d6e653_1280-spanish.jpg"),
    CuisineA("America", "images/hamburger-ga3f78a511_640-american.jpg"),
    CuisineA("British", "images/food-g34fd8a3b8_1280-british.jpg"),
    CuisineA("Thai", "images/fish-g33be0ef20_1280-thai.jpg"),
    CuisineA("Japanese", "images/sushi-g37aaa190d_1280-japanese.jpg"),
    CuisineA("Chinese", "images/dim-sum-g9d5f56483_1280-chinese.jpg"),
    CuisineA("Indian", "images/indian-food-g6c052f420_1280-indian.jpg"),
    CuisineA("French", "images/quiche-ga9a0acea2_1280-french.jpg"),
    CuisineA("Greek", "images/hummus-g95f7428ed_1280-greek.jpg"),
    CuisineA("Korean", "images/alum-gf52e26a7b_1280-korean.jpg"),
    CuisineA(
        "Turkish", "images/middle-eastern-food-gb320d4da1_1280-turkish.jpg"),
  ];

  void genNum() {
    randomNum = Random().nextInt(_cuisine.length);
  }

  String cuisineName() {
    return _cuisine[randomNum].cuisine;
  }

  String cuisineImg() {
    return _cuisine[randomNum].cuisineIMG;
  }
}

class foodQuoteA {
  late String quote;
  late String quoteFrom;

  foodQuoteA(String a, String b) {
    quote = a;
    quoteFrom = b;
  }
}

class FoodQuote {
  int randomNum = 0;

  List<foodQuoteA> _foodquote = [
    //https://www.delish.com/food/g25438962/food-quotes/?slide=21
    foodQuoteA(
        "All happiness depends on a leisurely breakfast.", "John Gunther"),
    foodQuoteA(
        "You don't need a silver fork to eat good food.", "Paul Prudhomme"),
    foodQuoteA(
        "I only drink Champagne on two occasions, when I am in love and when I am not.",
        "Coco Chanel"),
    foodQuoteA("A balanced diet is a cookie in each hand.", "Barbara Johnson"),
    foodQuoteA(
        "Cooking is like love. It should be entered into with abandon or not at all.",
        "Harriet Van Horne"),
    foodQuoteA(
        "People who love to eat are always the best people.", "Julia Child"),
    foodQuoteA("To eat is a necessity, but to eat intelligently is an art.",
        "François de la Rochefoucauld"),
    foodQuoteA(
        "We all eat, an it would be a sad waste of opportunity to eat badly.",
        "Anna Thomas"),
    foodQuoteA(
        "If you really want to make a friend, go to someone's house and eat with him...the people who give you their food give you their heart.",
        "Cesar Chavez"),
    foodQuoteA(
        "Always serve too much hot fudge sauce on hot fudge sundaes. It makes people overjoyed and puts them in your debt.",
        "Judith Olney"),
    foodQuoteA(
        "Ice cream is exquisite. What a pity it isn't illegal.", "Voltaire"),
    foodQuoteA(
        "Cooking is all about people. Food is maybe the only universal thing that really has the power to bring everyone together. No matter what culture, everywhere around the world, people eat together.",
        "Guy Fieri"),
    foodQuoteA(
        "The only time to eat diet food is while you're waiting for the steak to cook.",
        "Julia Child"),
    foodQuoteA("Laughter is brightest where food is best.", "Irish Proverb"),
    foodQuoteA("Life is a combination of magic and pasta.", "Federico Fellini"),
    foodQuoteA(
        "It's difficult to think anything but pleasant thoughts while eating a homegrown tomato.",
        "Lewis Grizzard"),
    foodQuoteA(
        "One cannot think well, love well, sleep well, if not has not dined well.",
        "Virginia Woolf"),
    foodQuoteA("Everything you see, I owe to spaghetti.", "Sophia Loren"),
    foodQuoteA("Age and glasses of wine should never be counted.", "Unknown"),
    foodQuoteA("I cook with wine. Sometimes I even add it to the food.",
        "W.C. Fields"),
  ];

  void genNum() {
    randomNum = Random().nextInt(_foodquote.length);
  }
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TestLocation(),
//     );
//   }
// }

// class TestLocation extends StatefulWidget {
//   @override
//   _TestLocationState createState() => _TestLocationState();
// }

// class _TestLocationState extends State<TestLocation> {
//   //late ShakeDetector detector;
//   int shakeCount = 0;
//
//   @override
//   double lat = 0;
//   double long = 0;
//
//   void initState() {
//     super.initState();
//     //TODO check if it is needed to create a detector
//     ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
//       setState(() {
//         print('I\'m shaking');
//         shakeCount++;
//       });
//       //bool isShake = true;
//
//       // Do stuff on phone shake
//     });
//     ;
//   }
//
//   void getCoordinate() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     lat = position.latitude;
//     long = position.longitude;
//     print('latitude is:$lat longitude:$long');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Center(
//             child: Column(children: [
//               ElevatedButton(
//                 onPressed: () {
//                   getCoordinate();
//                   print('recorded coordinate');
//                   //shake();
//                 },
//                 child: const Text('get coordinate'),
//               ),
//               SizedBox(height: 24),
//               Text(
//                 shakeCount.toString(),
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   MapsLauncher.launchCoordinates(lat, long);
//                 },
//                 child: const Text('View on map'),
//               ),
//               // Center(
//               //   child: FutureBuilder<Album>(
//               //     future: futureAlbum,
//               //     builder: (context, snapshot) {
//               //       if (snapshot.hasData) {
//               //         //return Text(snapshot.data!.id.toString()),
//               //         print(snapshot.data!.id.toString());
//               //       } else if (snapshot.hasError) {
//               //         return Text('${snapshot.error}');
//               //       }
//               //
//               //       // By default, show a loading spinner.
//               //       return const CircularProgressIndicator();
//               //     },
//               //   ),
//               // ),
//               // Container(
//               //   child: _loadedPhotos.length == 0
//               //       ? Center(
//               //           child: ElevatedButton(
//               //             child: Text('Load Photos'),
//               //             onPressed: _fetchData,
//               //           ),
//               //         )
//               //       // The ListView that displays photos
//               //       : ListView.builder(
//               //           itemCount: _loadedPhotos.length,
//               //           itemBuilder: (BuildContext ctx, index) {
//               //             return ListTile(
//               //               leading: Image.network(
//               //                 _loadedPhotos[index]["thumbnailUrl"],
//               //                 width: 150,
//               //                 fit: BoxFit.cover,
//               //               ),
//               //               title: Text(_loadedPhotos[index]['title']),
//               //               subtitle:
//               //                   Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
//               //             );
//               //           },
//               //         ),
//               // ),
//             ]),
//           )),
//     );
//   }
// }*/
