import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Wohin Essen'),
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.yellow,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: AssetImage('images/cafe-g8ca6d84c5_1280-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Wohin Essen?',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  elevation: MaterialStateProperty.all(0)),
              onPressed: () {},
              child: Text(
                'Start',
                style: TextStyle(fontSize: 50),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Login/ Sign up'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('About'),
            ),
          ],
        ),
      ),
      drawer: Container(
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
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              // title: Text("Sign in"),
                              content: SizedBox(
                                height: 220,
                                child: Column(
                                  children: [
                                    Text("Sign in"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                                      height: 10,
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
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() async {
                                            //print(email);
                                            //},
                                            try {
                                              final newUser = await _auth
                                                  .signInWithEmailAndPassword(
                                                      email: email.trim(),
                                                      password:
                                                          password.trim());
                                              if (newUser != 'null') {
                                                print("logined");
                                              }
                                            } catch (e) {
                                              print(e);
                                            }
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            Navigator.pop(context);

                                            print(email);
                                            print(password);
                                            print(_auth.currentUser?.email);
                                          });
                                        },
                                        child: Text('Sign in'))
                                  ],
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
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              // title: Text("Sign in"),
                              content: SizedBox(
                                height: 220,
                                child: Column(
                                  children: [
                                    Text("Register"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.emailAddress,
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
                                      height: 10,
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
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() async {
                                            //print(email);
                                            //},
                                            try {
                                              final newUser = await _auth
                                                  .createUserWithEmailAndPassword(
                                                      email: email.trim(),
                                                      password:
                                                          password.trim());
                                              if (newUser != 'null') {
                                                print("account created");
                                              }
                                            } catch (e) {
                                              print(e);
                                            }
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text('Register'))
                                  ],
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                            builder: (BuildContext context) => super.widget));
                    print('signed out');
                    print(_auth.authStateChanges());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
