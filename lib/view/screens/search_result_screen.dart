import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/model/apis/api_response.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';
import 'package:tentwenty_assignment/view_model/media_view_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List? mediaList = apiResponse.data as List?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return ListView.builder(
            itemCount: mediaList!.length,
            itemBuilder: (context, index) {
              final item = mediaList.elementAt(index);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ProgressiveImage(
                          placeholder:
                              const AssetImage('assets/placeholder.jpg'),
                          // size: 1.87KB
                          thumbnail: const NetworkImage(
                              'https://i.imgur.com/7XL923M.jpg'),
                          // size: 1.29MB
                          image: NetworkImage(
                            BaseService.imagesURL +
                                item['logo_path'].toString(),
                          ),
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item['name'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: .8,
                            ),
                            Shadow(
                              color: Colors.black45,
                              blurRadius: .8,
                            )
                          ],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search '),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse =
        Provider.of<MediaViewModel>(context).responseSEARCH;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            '${apiResponse.data == null ? 0 : (apiResponse.data as List).length.toString()} Results Found'),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: getMediaWidget(context, apiResponse),
    );
  }
}
