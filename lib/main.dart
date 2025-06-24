import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reqres_app/notificationCode/NotificationController.dart';
import 'app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Always initialize Awesome Notifications
  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();
  runApp(const ReqResApp());
}
