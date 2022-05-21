import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/model/apis/api_response.dart';
import 'package:tentwenty_assignment/model/media.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';
import 'package:tentwenty_assignment/view/screens/details_screen.dart';
import 'package:tentwenty_assignment/view/screens/search_screen.dart';
import 'package:tentwenty_assignment/view_model/media_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<Media>? mediaList = apiResponse.data as List<Media>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: mediaList!.length,
              itemBuilder: (context, index) {
                final item = mediaList.elementAt(index);
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => DetailsScreen(model: item),
                    ),
                  ),
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
                                BaseService.imagesURL + item.previewUrl!),
                            height: 200,
                            width: 500,
                          ),
                        ),
                        Positioned(
                          child: Text(
                            item.trackName!,
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
    ApiResponse apiResponse = Provider.of<MediaViewModel>(context).response;
    return Scaffold(
      bottomNavigationBar: bootomNavigationBar(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Watch'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<MediaViewModel>().fetchGenereList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => SearchScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: getMediaWidget(context, apiResponse)),
        ],
      ),
    );
  }

  Widget bootomNavigationBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff2E2739),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: 'watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_media_sharp),
            label: 'Media library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
