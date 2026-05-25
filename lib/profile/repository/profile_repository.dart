import 'dart:convert';

import 'package:flutter_counter_bloc/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final http.Client httpClient;

  ProfileRepository({required this.httpClient});

  Future<ProfileModel> getProfile({required String token}) async {
    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.get(
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/users/me'),
      headers: headers,
    );
    print("Response get profile: ${response.body}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProfileModel.fromMap(json);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
