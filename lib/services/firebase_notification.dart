// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:intl/intl.dart';
//
// class FirebaseNotification {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   badge: true,
//   sound: true,
//   );
// if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// // Permission granted
// } else {
// // Permission not granted
// }
//
//   DateTime expectedInTime =  DateFormat.Hms().format(DateTime.now()); // Get the expected in-time from your database or other source
//   DateTime actualInTime = ...; // Get the actual in-time recorded by your app
//   Duration lateness = actualInTime.difference(expectedInTime);
//   if (lateness > Duration(minutes: 10)) {
//   // User is more than 10 minutes late, send a notification
//   FirebaseMessaging.instance.send(
//   // Replace the `to` field with the FCM token of the user you want to notify
//   // You can get the token from FirebaseMessaging.instance.getToken()
//   // or by sending it from the app to your server and storing it in a database
//   Message(
//   to: 'FCM_TOKEN_OF_USER',
//   notification: Notification(
//   title: 'Late Attendance',
//   body: 'You are more than 10 minutes late for attendance',
//   ),
//   ),
//   );
//   }
//
// }