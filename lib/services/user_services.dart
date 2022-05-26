import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:macprojet/models/current_user.dart';
import 'package:macprojet/services/api.dart';
import 'package:macprojet/models/user';

class UserServices {
  Future login(User user) async {
    var response = await http.get(Uri.parse(API().BASE_URL +
        API().LOGIN +
        "email=" +
        user.email! +
        "&" +
        "password=" +
        user.password!));

    return response;
  }

  Future register(User user) async {
    Map<String, dynamic> u = user.toJson();
    print(u);

    var response = await http.post(Uri.parse(API().BASE_URL + API().REGISTER),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
          "firstName": user.firstName,
          "lastName": user.lastName,
          "password": user.password,
          "username": "username",
          "email": user.email,
          "photo": "photo",
          "phone": user.phone,
          "codePostal": 1200,
          "location": user.location
        }));
    return response;
  }

  Future updateImage(File image) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(API().BASE_URL +
            API().UPDATE_PHOTO +
            "?email=" +
            CurrentUser.email!));

    request.files.add(await http.MultipartFile.fromPath("photo", image.path));
    http.StreamedResponse response = await request.send();

    return response;
  }
}
