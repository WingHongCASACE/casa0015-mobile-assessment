import 'package:flutter/material.dart';

import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: aboutPage(),
    );
  }
}

class aboutPage extends StatefulWidget {
  @override
  _aboutPageState createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "Feeling Hungry ?",
        description: "Have you ever felt difficult to decide a dinning place?"
            " Struggle no more as this App will fairly suggest a place for you.",
        image: "images/icons8-hungry-100.png"),
    SliderPage(
        title: "Draw",
        description:
            "Based on where you are, a dinning place nearby will be suggested to you. Also try shaking the phone!",
        image: "images/icons8-lottery-100.png"),
    SliderPage(
        title: "Reserve",
        description: "Sign-in to reserve a table and to view booking history",
        image: "images/icons8-booking-100.png"),
    SliderPage(
        title: "About",
        description:
            "This App is an assignment for CASA0015 - Mobile Systems & Interactions, a module in MSc Connected Environments, University College London.",
        image: "images/icons8-about-100.png"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.grey.shade800, BlendMode.darken),
                image: AssetImage(
                    'images/table-g11cd0446b_1280-aboutpage-background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onchanged,
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.5)));
                  })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      {
                        _controller.previousPage(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOutQuint);
                      }
                      ;
                    },
                    //},
                    child: Icon(Icons.navigate_before),
                    style: ButtonStyle(
                      foregroundColor: (_currentPage == 0)
                          ? MaterialStateProperty.all(Colors.transparent)
                          : MaterialStateProperty.all(Colors.white),
                      backgroundColor: (_currentPage == 0)
                          ? MaterialStateProperty.all(Colors.transparent)
                          : MaterialStateProperty.all(Colors.blueAccent),
                      elevation: (_currentPage == 0)
                          ? MaterialStateProperty.all(0)
                          : MaterialStateProperty.all(1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homePage()),
                      );
                      print('back to home');
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOutQuint);
                    },
                    child: Icon(Icons.navigate_next),
                    style: ButtonStyle(
                      foregroundColor: (_currentPage == _pages.length - 1)
                          ? MaterialStateProperty.all(Colors.transparent)
                          : MaterialStateProperty.all(Colors.white),
                      backgroundColor: (_currentPage == _pages.length - 1)
                          ? MaterialStateProperty.all(Colors.transparent)
                          : MaterialStateProperty.all(Colors.blueAccent),
                      elevation: (_currentPage == _pages.length - 1)
                          ? MaterialStateProperty.all(0)
                          : MaterialStateProperty.all(1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  SliderPage(
      {required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            color: Colors.white,
          ),
          //SvgPicture.asset(
          //   image,
          //   width: width * 0.6,
          // ),
          SizedBox(
            height: 60,
          ),
          SizedBox(
            // height: 60,
            //width: 100,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                description,
                style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                    letterSpacing: 0.7,
                    color: Colors.white),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
