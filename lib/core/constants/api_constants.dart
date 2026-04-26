import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get baseUrl {
    if (Platform.isIOS) {
      return dotenv.env['IOS_BASE_URL']!;
    }
    return dotenv.env['ANDROID_BASE_URL']!;
  }

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/user/profile';
  static const String netWorth = '/networth';
  static const String assets = '/assets';
}
