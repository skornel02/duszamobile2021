# Software plan

## Tool choice

We have decided on [Flutter](https://flutter.dev/), for the following reasons:

 * Multi platform audience (Android, IOS, Web)
 * Rich ecosystem of libraries
 * Fast development cycle (Important here!)

The following drawbacks we are expecting:

 * Bigger application size
 * Longer loading times
 * Second class integration (No widgets on Android)

## Project structure

In accordance with Flutter coding practices the project is divided into the following folders:
 
 * /ios - IOS specific code
 * /android - Android specific code
 * /web - Web specific code
 * /lib - Application code
 * /assets - Assets for application
 * /test - Tests for the application

### Library structure

The code has been structured into packages based on their fulfilled roles (e.g.: Charts are in /statistics).

### Translation

To make the application more accessible multiple translations exist for the program's string base.

Translation files can be found in the `/lib/l10n/` folder.

## Code quality

The code is formatted and written in accordance of Flutter's [official style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo). 

### Formatting

The project is formatted by the build in `flutter format` tool to be up to standard.

## Application structure

The application is structured around paths like a traditional web application. This allows us to retain session, create shareable links and simplify code splitting. 

### Routing

To achieve routing we use the [Modular library](https://modular.flutterando.com.br/) 

The routing table of the project can be found in `/lib/app_module.dart`.

### Data structure

The data structure can be found in the `/lib/resources` folder. 

### Data storage

The backend of data storage has been generified and can be found in `/lib/repositories/account_repository.dart`

Currently one implementation exists, that uses the User's shared preferences. This might be upgraded to an online storage like Google Drive in the future.

## Setting the project up

First step is to install the dependencies (prior Flutter installation is expected)
```
flutter pub get
```
---

After that you can run the project
```
flutter run
```
This will prompt the user to choose their device to run on. You may choose an Android device, emulator or browser.

---

To build the project you have to choose the target platform
```
flutter build apk # Android app
flutter build web # Website
```