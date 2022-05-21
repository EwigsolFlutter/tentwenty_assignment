import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/model/apis/api_response.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';
import 'package:tentwenty_assignment/view/screens/search_result_screen.dart';
import 'package:tentwenty_assignment/view_model/media_view_model.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  SearchScreen({Key? key}) : super(key: key);
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List? mediaList = apiResponse.data as List?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: mediaList!.length,
              itemBuilder: (context, index) {
                final item = mediaList.elementAt(index);
                return InkWell(
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (builder) => DetailsScreen(model: item),
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ProgressiveImage(
                            placeholder:
                                const AssetImage('assets/placeholder.jpg'),
                            // size: 1.87KB
                            thumbnail: const NetworkImage(
                                'https://i.imgur.com/7XL923M.jpg'),
                            // size: 1.29MB
                            image: NetworkImage(
                                BaseService.imagesURL + item.toString()),
                            height: 200,
                            width: 500,
                          ),
                        ),
                        Positioned(
                          child: Text(
                            item['name'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
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
                          bottom: 20,
                          left: 20,
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
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
        Provider.of<MediaViewModel>(context).responseGenre;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 70),
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              fillColor: const Color(0xffF2F2F6),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    color: Color(0xffF2F2F6),
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    color: Color(0xffF2F2F6),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    color: Color(0xffF2F2F6),
                  )),
              hintText: 'TV shows, movies and more',
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.clear),
              ),
              prefixIcon: IconButton(
                  onPressed: () {
                    context.read<MediaViewModel>().fetchSearch(controller.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ccc) => const ResultScreen()));
                  },
                  icon: const Icon(Icons.search)),
            ),
            onChanged: (c) {
              // context.read<MediaViewModel>().fetchSearch(controller.text);
              print(c);
            },
          ),
        ),
      ),
      body: getMediaWidget(context, apiResponse),
    );
  }
}
