import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentwenty_assignment/view/screens/login.dart';
import 'package:tentwenty_assignment/view_model/posts_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostViewModel>(
      create: (create) => PostViewModel(),
      child: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const LoginScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Consumer<PostViewModel>(builder: (context, model, _) {
      return model.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : model.postsList.isEmpty
              ? const Center(
                  child: Text("Empty "),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: model.postsList.length,
                  itemBuilder: (context, index) {
                    final item = model.postsList.elementAt(index);
                    return ListTile(
                      leading: Text(item.id.toString()),
                      title: Text(item.title.toString()),
                      subtitle: Text(item.body.toString()),
                    );
                  },
                );
    });
  }
}
