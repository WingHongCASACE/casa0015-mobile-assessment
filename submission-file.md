<!---

---
title: "CASA0017: Web Architecture Final Assessment"
author: "Wing Hong OR"
date: "17 May 2022"
---

-->

## Link to GitHub Repository
Wohin Essen - Let the App help you deciding where to eat  
GitHub Repository - [https://github.com/WingHongCASACE/casa0015-mobile-assessment](https://github.com/WingHongCASACE/casa0015-mobile-assessment)

## Introduction to Application
To ease decidophobia from too many dining options, and to enhance excitement from exploring unvisited dining places, the App *Wohin Essen* will generate a meal place that is near the users' current or input locations. 

The App has a home page, a page to decide whether the current location or a specified location to be used, a drawing result page, a reservation page, an about page, and a reservation record page. Flutter package *geolocator* is used to obtain user’s current location, whereas Google Maps API *geocode* is used when user specify a site. In both cases the coordinates are fed into another Google Maps API *nearby search* which returns the restaurants nearby. A restaurant will be picked from the list and its information will be displayed, user can decide to visit there, draw again, change location, or make a reservation. 

The App uses 2 services from Firebase: *Authentication* and *Firestore Database*, are used for signing up/ login function and reservation management. Users can register an account and sign-in, which enables them to view their records. 

Some user-experience elements have been added to the application. For example, a list of food quotes was stored locally in the App and a quote will be picked randomly and displayed. In addition, package *animated_text_kit* was applied for text animation. 



## Biblography

1. Andrianto, I. (2021). 'Flutter - Hide Keyboard on Tap Outside Text Field', Woolha.com, 20 Jun. Available at: https://www.woolha.com/tutorials/flutter-hide-keyboard-on-tap-outside-text-field (Access: 17 May 2022).
2. Ayushagarwal.ml. (2021). 'animated_text_kit 4.2.1', pub.dev, 18 Feb. Available at: https://pub.dev/packages/animated_text_kit (Access: 24 Apr 2022).
3. ArtificialOG. (2018) Indian Food [Photograph]. Available at: https://pixabay.com/photos/indian-food-indian-kitchen-meal-3856050/ (Access: 17 May 2022).
4. Balazs, B. (2016) Hamburger [Photograph]. Available at: https://pixabay.com/photos/hamburger-fries-coleslaw-food-1281855/ (Access: 17 May 2022).
5. Baseflow.com. (2022). 'geolocator 8.2.1', pub.dev, 5 May. Available at: https://pub.dev/packages/geolocator (Access: 17 May 2022).
6. Cheung, A. (2017) Dim Sum [Photograph]. Available at: https://pixabay.com/photos/dim-sum-dim-sim-food-hong-kong-2346105/ (Access: 17 May 2022).
7. Chongodog (2018) Fish and Chips [Photograph]. Available at: https://pixabay.com/photos/food-fish-chips-fish-and-chips-3687804/ (Access: 17 May 2022).
8. Dart.dev. (2021). 'http 0.13.4', pub.dev, 4 Oct. Available at: https://pub.dev/packages/http (Access: 17 May 2022).
9. Dart.dev. (2022). 'collection 1.16.0', pub.dev, 8 Mar. Available at: https://pub.dev/packages/collection (Access: 17 May 2022).
10. Emilio, J. (2017) Sushi [Photograph]. Available at: https://pixabay.com/photos/sushi-salmon-japanese-2455981/ (Access: 17 May 2022).
11. EstudioWebDoce (2016) Paella [Photograph]. Available at: https://pixabay.com/photos/paella-lena-mixed-valencian-1167973/ (Access: 17 May 2022).
12. Firebase.google.com. (2022). 'firebase_core 1.17.0', pub.dev, 13 May. Available at: https://pub.dev/packages/firebase_core (Access: 17 May 2022).
13. Firebase.google.com. (2022). 'firebase_auth 3.3.18', pub.dev, 13 May. Available at: https://pub.dev/packages/firebase_auth (Access: 17 May 2022).
14. Firebase.google.com. (2022). 'cloud_firestore 3.1.15', pub.dev, 13 May. Available at: https://pub.dev/packages/cloud_firestore (Access: 17 May 2022).
15. Grabowska, K. (2015) Table [Photograph]. https://pixabay.com/photos/table-chairs-chair-restaurant-791167/ (Access: 17 May 2022).
16. Gutebring, M. (2021) Toast [Photograph]. Available at: https://pixabay.com/photos/toast-skagen-dish-food-starter-5978803/ (Access: 17 May 2022).
17. Hiroé, J. (2020) House [Photograph]. https://pixabay.com/photos/house-table-fireplace-wood-5632318/ (Access: 17 May 2022).
18. Icons8. (no date) Icons8-about-10 [Photograph]. Available at: https://icons8.com/icon/3439/about (Access: 17 May 2022).
19. Icons8. (no date) Icons8-hungry-100 [Photograph]. Available at: https://icons8.com/icon/bSUU2CsAJypm/hungry (Access: 17 May 2022).
20. Icons8. (no date) Icons8-lottery-100 [Photograph]. https://icons8.com/icon/38yd4ysLmGRK/lottery (Access: 17 May 2022).
21. Icons8. (no date) Icons8-booking-100 [Photograph]. https://icons8.com/icon/78945/booking (Access: 17 May 2022).
22. Joshi.dev. (2022). 'shake 2.1.0', pub.dev, 17 Apr. Available at: https://pub.dev/packages/shake (Access: 17 May 2022).
23. Jyleen21. (2015) Korean Food [Photograph]. Available at: https://pixabay.com/photos/alum-dining-food-korean-749358/ (Access: 17 May 2022).
24. Mikes-Photography. (2016) Table [Photograph]. https://pixabay.com/photos/sandwich-food-meal-lunch-lettuce-1643653/ (Access: 17 May 2022).
25. Ponce, A. (2016) Pizza [Photograph]. Available at: https://pixabay.com/photos/pizza-garlic-cutting-board-1442945/ (Access: 17 May 2022).
26. Richard, M. (2017) Table [Photograph]. https://pixabay.com/photos/lisbon-timeout-food-hall-market-2660748/ (Access: 17 May 2022).
27. Rita. (2016) Quiche [Photograph]. Available at: https://pixabay.com/photos/quiche-quiche-lorraine-bacon-onion-1579383/ (Access: 17 May 2022).
28. Skitterians, J. and Skitterians, R. (2014) Table [Photograph]. https://pixabay.com/photos/bistro-cafe-restaurant-tables-498504/ (Access: 17 May 2022).
29. Socha, A. (2017) Fish [Photograph]. Available at: https://pixabay.com/photos/fish-food-thai-thailand-dinner-2105233/ (Access: 17 May 2022).
30. Stina_magnus. (2015) Taco [Photograph]. Available at: https://pixabay.com/photos/taco-mexican-beef-food-1018962/ (Access: 17 May 2022).
31. Timokefoto. (2021) Turkish Food [Photograph]. Available at: https://pixabay.com/photos/middle-eastern-food-kebab-6615971/ (Access: 17 May 2022).
32. Unverified uploader. (2021). 'maps_launcher 2.0.1', pub.dev, 29 Jun. Available at: https://pub.dev/packages/maps_launcher (Access: 17 May 2022).
33. Unverified uploader. (2021). 'modal_progress_hud_nsn 0.1.0-nullsafety-1', pub.dev, 18 Feb. Available at: https://pub.dev/packages/modal_progress_hud_nsn (Access: 18 Feb 2022).
34. Unverified uploaderl. (2022). 'flutter_screenutil 5.5.3+1', pub.dev, 18 Feb. Available at: https://pub.dev/packages/flutter_screenutil (Access: 17 May 2022).
35. Velázque, E. (2021) Table [Photograph]. https://pixabay.com/photos/cafe-street-netherlands-europe-6614233/ (Access: 17 May 2022).
36. Velis, J. (2016) Hummus [Photograph]. Available at: https://pixabay.com/photos/hummus-falafel-authentic-greek-1649231/ (Access: 17 May 2022).
37. Weinberg, S. (2018). 'The All-Time Greatest Quotes About Food And Eating', Delish, 7 Dec. Available at: https://www.delish.com/food/g25438962/food-quotes/?slide=21 (Access: 17 May 2022).
38. '3888952'. (2016) Cafe [Photograph]. Available at: https://pixabay.com/photos/cafe-restaurant-chairs-tables-1872888/ (Access: 17 May 2022).

----

## Declaration of Authorship

I, Wing Hong OR, confirm that the work presented in this assessment is my own. Where information has been derived from other sources, I confirm that this has been indicated in the work.

#### OR WH

17 May 2022
