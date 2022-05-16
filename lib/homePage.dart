import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ucfnwho_assignment/locatePage.dart';
import 'package:ucfnwho_assignment/reserveRecord.dart';

import 'aboutPage.dart';
import 'locatePage.dart';

final _auth = FirebaseAuth.instance;
//User loggedInUser;

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late String email;
  late String password;
  late String name;
  bool loadingSpin = false;
  String errorMsg = '';
  DateTime firstBackPress = DateTime.now();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timeDiff = DateTime.now().difference(firstBackPress);
        final exitApp = timeDiff >= Duration(seconds: 2);
        firstBackPress = DateTime.now();
        if (exitApp) {
          final snack = SnackBar(
            content: Container(
              height: 40,
              child: Text(
                'Press Back button again to Exit',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _key,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
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
                  'images/cafe-g8ca6d84c5_1280-homepage-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 60, color: Colors.white),
                    child: AnimatedTextKit(
                      animatedTexts: [WavyAnimatedText('Wohin Essen?')],
                    ),
                  ),
                ),
                Text(
                  'Let the App help you deciding where to eat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.withOpacity(0.3),
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => locatePage()),
                          );
                        },
                        child: Text(
                          'Start',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.withOpacity(0.3),
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Text(
                          'Log in/ Register',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.withOpacity(0.3),
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => aboutPage()),
                          );
                        },
                        child: Text(
                          'About',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                                borderRadius: BorderRadius.all(
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
                                                borderRadius: BorderRadius.all(
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
                                                          password:
                                                              password.trim());
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
                                                                super.widget));
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
                                                print(_auth.currentUser?.email);
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
                                      height: 350,
                                      child: Column(
                                        children: [
                                          Text("Register"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            onChanged: (value) {
                                              name = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "User name",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
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
                                                borderRadius: BorderRadius.all(
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
                                                borderRadius: BorderRadius.all(
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
                                                          password:
                                                              password.trim());
                                                  newUser.user
                                                      ?.updateDisplayName(name);
                                                  if (newUser != 'null' &&
                                                      newUser.user
                                                              ?.displayName !=
                                                          'null') {
                                                    print("Account created");
                                                    setState(() {
                                                      loadingSpin = false;
                                                    });
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                super.widget));
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
                                                print(_auth.currentUser?.email);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reserveRecord()),
                      );
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
      ),
    );
  }
}
