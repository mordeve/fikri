import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setQuantities(Map<String, dynamic> data, String email) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('${email}_quantities', json.encode(data));
}
