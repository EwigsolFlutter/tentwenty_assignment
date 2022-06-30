import 'package:flutter/cupertino.dart';
import 'package:tentwenty_assignment/model/auth_repository.dart';
import 'package:tentwenty_assignment/model/posts_model.dart';

class PostViewModel with ChangeNotifier {
  List<Posts> postsList = [];
  bool isLoading = true;

  PostViewModel() {
    getPots();
  }

  Future<void> getPots() async {
    //fetch all posts
    postsList = await APIRepository().getPosts();
    isLoading = false;
    notifyListeners();
  }
}
