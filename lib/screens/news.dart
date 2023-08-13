import 'package:flutter/material.dart';
import 'package:status_code0/models/networking.dart';
import 'package:status_code0/widgets/news_tile.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key, required this.healthdata});
  final Map<String, dynamic> healthdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "News",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.onPrimaryContainer,
            ],
            // begin: Alignment.bottomRight,
            // end: Alignment.topLeft,
          )),
          child: Column(
            children: [
              Expanded(
                child: NewsList(
                  news: healthdata,
                ),
              ),
            ],
          ),
        ));
  }
}

class NewsList extends StatelessWidget {
  const NewsList({
    super.key,
    this.dropdownvalue,
    this.news,
  });

  // final List<NewsTile>? news;

  final String? dropdownvalue;
  final Map<String, dynamic>? news;
  String nullchecker(dynamic url) {
    url =
        "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png";
    return url;
  }

  @override
  Widget build(BuildContext context) {
    // List<NewsTile> newlist = SortedList(dropdownvalue, blogcontent);

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      itemBuilder: (context, index) {
        dynamic imageurl = news!['articles'][index]['urlToImage'];

        if (imageurl == null) imageurl = nullchecker(imageurl);
        print(imageurl);
        return NewsTile(
            // text: (news!['articles'][index]['title'])
            text: news!['articles'][index]['title'],
            url: imageurl);
      },
      itemCount: news!['articles'].length,
      // print(news!.length)
      separatorBuilder: (BuildContext context, index) => Divider(),
    );
  }
}
