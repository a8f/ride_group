# ride_group

Ridesharing app


## Development (Android)

- Set up and run the [server](https://github.com/git-uname/ride_group_server)
- Set `Server.endpoint` in `lib/server.dart` to the url the server is running on
- Get `google-services.json` from the app in [the Firebase Console](https://console.firebase.google.com) and put it in `android/app/`
    - If you haven't already, you can generate a fingerprint for development to register to the app with `keytool -list -v -keystore ~/.android/dev.keystore -alias dev -storepass android -keypass android`
- Set the Google Maps API key in `android/app/src/main/AndroidManifest.xml`
- Get dependencies with `flutter pub get`
- Generate strings with `flutter pub run gen_lang:generate`
- Build and run the app
