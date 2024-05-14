// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:dart_id/dart_id.dart';
import 'package:mongez_shared_code/utils/global_utils.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Logger logger = Logger();
bool manualDebugging = true;
Locale? loadedCurrentLocale;
GlobalUtils globalUtils = GlobalUtils(navigatorKey: navigatorKey);
DartID dartId = DartID();
Dio dio = Dio();
