import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tentwenty_assignment/model/posts_model.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';

class APIRepository extends BaseService {
  @override
  Future<List<Posts>> getPosts() async {
    List<Posts> lst = [];
    try {
      final response = await http.get(Uri.parse(BaseService.postsAPI));
      print(response.body);
      lst = (jsonDecode(response.body) as List)
          .map((e) => Posts.fromJson(e))
          .toList();
    } catch (e) {
      log(e.toString());
    }
    return lst;
  }

  @override
  Future<bool> login(String email, String password, String deviceToken) async {
    bool isLogin = false;
    deviceToken = 'zasdcvgtghnkiuhgfde345tewasdfghjkm';
    try {
      //prepare Body Data
      var mapBodyData = {
        "email": email,
        "password": password,
        "device_token": deviceToken,
      };

      print(mapBodyData);

      //calling API
      final response = await http.post(
        Uri.parse(BaseService.loginAPI),
        body: mapBodyData,
      );
      //
      log(response.body, name: "LOGIN DATA");
      if (response.body.contains('"status":200')) {
        isLogin = true;
      }
    } catch (e) {
      log(e.toString());
    }
    return isLogin;
  }
}
