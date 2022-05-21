import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/model/media.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';
import 'package:tentwenty_assignment/view/screens/player_screen.dart';
import 'package:tentwenty_assignment/view_model/media_view_model.dart';

class DetailsScreen extends StatelessWidget {
  final Media model;
  const DetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                detailsImage(model: model),
                const DetailAppBar(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "In theaters ${DateFormat.yMMMMd('en_US').format(DateTime.now())}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff61C3F2),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Get Tickets",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    const BorderSide(color: Color(0xff61C3F2)),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<MediaViewModel>()
                                      .fetchVideoDataKey(
                                          model.artistName.toString());

                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (builder) => PlayerFirstScreen(
                                          id: model.artistName.toString(),
                                        ),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    Text(
                                      "Watch Trailer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Genres",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  // const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Chip(
                        label: Text(
                          'Action',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xff15D2BC),
                      ),
                      Chip(
                        label: Text(
                          'Thriller',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xffE26CA5),
                      ),
                      Chip(
                        label: Text(
                          'Science',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xff564CA3),
                      ),
                      Chip(
                        label: Text(
                          'Fiction',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xffCD9D0F),
                      ),
                    ],
                  ),
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    model.overview.toString(),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_sharp,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          const Text(
            'Watch',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class detailsImage extends StatelessWidget {
  const detailsImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Media model;

  @override
  Widget build(BuildContext context) {
    return ProgressiveImage(
      placeholder: const AssetImage('assets/placeholder.jpg'),
      // size: 1.87KB
      thumbnail: const NetworkImage('https://i.imgur.com/7XL923M.jpg'),
      // size: 1.29MB
      image: NetworkImage(BaseService.imagesURL + model.previewUrl!),
      height: 800,
      width: 500,
    );
  }
}
