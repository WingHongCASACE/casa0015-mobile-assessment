# Wohin Essen
## Let the App help you deciding where to eat
:hotdog: &emsp; &emsp; :taco: &emsp; &emsp; :stew: &emsp; &emsp; :sushi: &emsp; &emsp; :tropical_drink: &emsp; &emsp; :pie: &emsp; &emsp; :oden: &emsp; &emsp; :dumpling: &emsp; &emsp; :curry: &emsp; &emsp; :pancakes: &emsp; &emsp; :shallow_pan_of_food: &emsp; &emsp; :fried_shrimp: &emsp; &emsp; :doughnut: &emsp; &emsp;   
This App will suggest a dining place for user, in order to release the (potential stress or pain) from deciding a place to eat. User can provide his/her current location or to specifiy one, then a dining place nearby will be suggested. If desired, user can make a reservation. When logged-in reservation record can be viewed.

## App feature

The App mainly consists of a home page, a page to decide whether the current location or a specified location to be used, a result page, a reservation page, an about page, and a reservation record page (for account user). Users can register an account and sign-in, which enables them to view their records.

<p align="center">
<img src="https://user-images.githubusercontent.com/91855312/168930746-abdf94b4-24a8-4590-9591-fbb7f2e59804.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168930750-b3426d9e-ad4a-40b6-bc72-9ccfb5c116a9.jpg" width=20%/><br>App icon and home page<br><br><br>
<img src="https://user-images.githubusercontent.com/91855312/168931244-e63a51d9-544b-44dc-b602-c84eda89dd25.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931249-473fb5c7-44ab-4232-a1dc-1054f22ea34b.jpg" width=20%/><br>User can decide to create an account or not. Guest and account user have different navigation drawer interfaces. Once logged-in users can view their reservation record in listview format.<br><br><br>
<img src="https://user-images.githubusercontent.com/91855312/168931472-1ac1b2df-9918-462f-b010-e7815f33d956.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931476-61ab7526-fa09-4e01-967c-40dafbdceb6c.jpg" width=20%/><br>Users can decide whether to use the current location or specify a location for dining place suggestion generation. After confirming the method (and location for specifying a place) users can proceed by clicking the bottom navigation bar. Alternatively user can shake the phone and start the drawing.<br><br><br>
<img src="https://user-images.githubusercontent.com/91855312/168931762-f1336732-8cfd-456e-bdce-0c3eb251541d.JPG" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931785-ef917910-6a56-4782-a4e8-7c68c718ab93.JPG" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931530-d671c8ce-a3cf-4d75-b95e-97c19148893f.jpg" width=16%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931533-a78a734c-2ece-4eca-9db2-d6bb55c7b6aa.jpg" width=16%/><br>The transaction screens show a quote about food. It was randomly drew from a list of quotes saved in the App. The result shows the information of the dining place including the name, price and rating, as well as the address. On the other hand, the photo was drew from a list of photos saved in the App which may not represent the cuisine. This is due to the abscence of images proved by the appointed API (Google maps nearby search). Users can navigate to the dining place address on google map via package 'maps_launcher'.<br><br><br>
<img src="https://user-images.githubusercontent.com/91855312/168931610-b2412a99-8a89-421a-9d33-b06e9ca0bd2c.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931611-2926c498-5428-446a-9613-db64801eec3d.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168931606-95f415f4-803d-449a-b678-536f2152371c.jpg" width=20%/><br>If signed-in, the default name and contact information will be suggested. All fields have to be filled or warning will appear. Once successfully submitted user will be notified. <br><br><br>
<img src="https://user-images.githubusercontent.com/91855312/168933537-df15d158-70ea-4f28-9539-ded9fa91e267.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168933540-66a50462-788c-4bd7-8930-b4a5877811ec.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168933541-c8ca8936-6c39-4073-a99a-6d2e5b09bbaa.jpg" width=20%/>&nbsp<img src="https://user-images.githubusercontent.com/91855312/168933542-e912ca34-17ec-43f1-b69e-8b8e06f7257a.jpg" width=20%/><br>Users can click the buttons or swipe to left/right to move between subpages.<br>
   
https://user-images.githubusercontent.com/91855312/168933151-9f2ff638-8b33-40df-9a46-28e83d89f823.mp4





https://user-images.githubusercontent.com/91855312/168933161-46ded0e9-593a-46c1-a233-aef0ace257f6.mp4



## Using The App    

For developer who wants to refine/extend the App, please go to [the master branch: WingHongCASACE/casa0015-mobile-assessment/tree/master](https://github.com/WingHongCASACE/casa0015-mobile-assessment/tree/master) and download the whole folder and manage/ edit it in your preferable IDE. Please also install [Flutter](https://docs.flutter.dev/get-started/install) and an IDE such as [Android Studio](https://developer.android.com/studio/install).

This App uses 2 google maps APIs: geocode and nearby search. In addition, it uses 2 services from Firebase: Authentication and Firestore Database. Please replace with you own API key for geocode and nearby search function. For Firebase application, please create a firebase project. Register you App on Firebase by providing your own ```applicationID``` in ```android>app>build.grade``` (for Android App) and download and (re)place the json config file in the Android app module root directory.   

For getting a key for google maps APIs, please refer to [here](https://developers.google.com/maps/documentation/javascript/get-api-key#:~:text=Go%20to%20the%20Google%20Maps%20Platform%20%3E%20Credentials%20page.&text=On%20the%20Credentials%20page%2C%20click,Click%20Close.).  
To set up Firebase in your Flutter App, please refer to [here](https://firebase.google.com/docs/flutter/setup?platform=android).

  
  | Framework/Tools/Packages | Version in used |
  |--------------------------|-----------------|
  | Flutter | 2.10.3 |
  | SDK | >=2.15.1 <3.0.0 |
  | Dart | 2.16.1 |
  | DevTools | 2.9.2 |
  |---|---|
  | animated_text_kit | ^4.2.1 | 
  | cloud_firestore | ^3.1.14 |
  | collection | ^1.15.0 |
  | geolocator | ^8.2.0 |
  | firebase_core | ^1.16.0 |  
  | firebase_auth | ^3.3.17 |  
  | flutter_screenutil | ^5.5.2 |   
  | http | ^0.13.4 | 
  | maps_launcher | ^2.0.1 | 
  | modal_progress_hud_nsn | ^0.1.0-nullsafety-1 |  
  | shake | ^2.0.0 |  


### Copyright <2022 Wing Hong OR>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


##  Contact Details

I am happy to discuss about the App - please make a pull request, or contact by email: [ucfnwho@ucl.ac.uk](mailto:ucfnwho@ucl.ac.uk). Even more, I enjoy trying new restaurants and food. :pretzel:
