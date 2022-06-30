import 'package:tentwenty_assignment/model/posts_model.dart';

abstract class BaseService {
  // API's For HTTP Calling URL's
  static const loginAPI = 'http://buddy.ropstambpo.com/api/login';
  static const postsAPI = 'https://jsonplaceholder.typicode.com/Posts';

  // Functions To get/POst Data
  //Login Func Method=POST
  Future<bool> login(String email, String password, String deviceToken);
  // Get All Posts Method=GET
  Future<List<Posts>> getPosts();
}
