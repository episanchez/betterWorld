import 'dart:async';
import 'dart:convert';

import "package:better_world/logic/model/UserForm.dart";
import 'package:http/http.dart' as http;

//TODO Implement Singleton
class UserInterface {
  //final String host = "https://us-central1-betterworld-a04ef.cloudfunctions.net/";
  //final String endpoint = "app";
  final String host = "http://10.0.2.2:5000/betterworld-a04ef/us-central1/";
  final String endpoint = "test/";

  final String functions = "";

  Future<UserForm> fetchUserForm() async {
    final response =
    await http.get(host + endpoint);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return UserForm.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<http.Response> postUserForm(String userId, UserForm userForm) async {
    final postEndpoint = host + endpoint + "user/" + userId;
    print(postEndpoint);
    final response = await http.post(postEndpoint,
        headers: {"Content-Type": "application/json"},
        body: json.encode(userForm.toJson()));
  print(response);
    return response;
  }

}