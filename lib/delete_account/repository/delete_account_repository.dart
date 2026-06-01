import 'package:flutter_counter_bloc/delete_account/models/delete_account_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountRepository {
  final http.Client httpClient;

  DeleteAccountRepository({required this.httpClient});

  Future<DeleteAccountModel> deleteAccount({required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await http.delete(
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/users/delete'),
      headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
      body: jsonEncode({'password': password}),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DeleteAccountModel.fromMap(data);
    } else {
      throw Exception('Failed to delete account');
    }
  }
}
