import 'package:flutter/material.dart';
import '../main_drawer.dart';

import '../models/news.dart';
import '../helper/news.dart';
import '../widgets/news_tile.dart';

class TrendingTopScreen extends StatefulWidget {
  final String topic;
  TrendingTopScreen({this.topic});
  @override
  _TrendingTopScreenState createState() => _TrendingTopScreenState();
}

class _TrendingTopScreenState extends State<TrendingTopScreen> {

  List<NewsModel> articles = List<NewsModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrendingNews();
  }

  getTrendingNews() async{
    TrendingNewsClass newsClass = TrendingNewsClass();
    await newsClass.getNews(widget.topic);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  refresh() {
    setState(() {
      _loading = true;
      getTrendingNews();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TrendingTopScreen();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${widget.topic.toUpperCase()} NEWS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: (){
              refresh();
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: _loading ? Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: CircularProgressIndicator(),
          ),
        ) : Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index){
                return NewsTile(
                  imageUrl: articles[index].imageUrl,
                  title: articles[index].title,
                  desc: articles[index].desc,
                  source: articles[index].source,
                  timeStamp: articles[index].timestamp,
                  url: articles[index].url,
                );
              }),
        ),
      )
    );
  }
}
