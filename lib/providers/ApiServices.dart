import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

class ApiServices with ChangeNotifier {
  var registerPhone = "";
  var profileData;
  LoginPhoneNumber(val) {
    registerPhone = val;
    notifyListeners();
  }

  Future Register(username, email, phone) async {
    registerPhone = phone;
    notifyListeners();

    // 'username': username,
    //   'email': email,
    //   'phone': phone,
    //   'timestamp': DateTime.now().toString(),
    // final response = await http.post(
    //   Uri.parse("https://hhivaranasi.com/ijl/api/register.php"),
    //   body: formDataMap,
    //   // headers: <String, String>{
    //   //   // HttpHeaders.authorizationHeader: "Token $token",
    //   //   // HttpHeaders.acceptHeader: "text/plain",
    //   //   // HttpHeaders.contentTypeHeader: "application/json"
    //   // },
    // );
    print('username: ${username}.${email}.${phone}');
    final formData = FormData.fromMap({
      "username": "$username",
      "email": "$email",
      "mobile_no": "$phone",
      // 'timestamp': DateTime.now().toString(),
    });
    final response = await Dio()
        .post('https://hhivaranasi.com/ijl/api/signup.php', data: formData);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // final data = json.decode(response.body);
      // var jsonResponse =
      //     convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
      print('journey: ${response.data}.');

      notifyListeners();
      return response.data;
    } else {
      ;
      print('Request failed with status: ${response.statusCode}.');
      notifyListeners();
      throw "error";
    }
  }

  Future UserProfile(phone) async {
    registerPhone = phone;
    notifyListeners();

    final formData = FormData.fromMap({
      "mobile_no": "$phone",
      // 'timestamp': DateTime.now().toString(),
    });
    final response = await Dio()
        .post('https://hhivaranasi.com/ijl/api/profile.php', data: formData);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // final data = json.decode(response.body);
      // var jsonResponse =
      //     convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
      print('journey: ${response.data}.');
      if (response.data is List<dynamic>) {
        profileData = response.data[0];
      }

      notifyListeners();
      return response.data;
    } else {
      ;
      print('Request failed with status: ${response.statusCode}.');
      notifyListeners();
      throw "error";
    }
  }
}
