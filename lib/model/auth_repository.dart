import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tentwenty_assignment/model/posts_model.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';

import 'apis/app_exception.dart';

class APIRepository extends BaseService {
  @override
  Future<List<Posts>> getPosts() async {
    List<Posts> lst = [];
    try {
      final response = await http.get(Uri.parse(BaseService.postsAPI));
      lst = response.body as List<Posts>;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
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
        "deviceToken": deviceToken,
      };

      //calling API
      final response = await http.post(
        Uri.parse(BaseService.loginAPI),
        body: mapBodyData,
      );
      //
      log(response.body, name: "LOGIN");
      isLogin = true;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return isLogin;
  }
}
