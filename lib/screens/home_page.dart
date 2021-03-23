import 'package:flutter/material.dart';

import '../widgets/news_tile.dart';
import '../helper/news.dart';
import '../models/news.dart';
import '../widgets/categories.dart';
import '../main_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> articles = List<NewsModel>();
  bool _loading = true;

  @override
  void initState(){
    super.initState();
    getNews();
  }

  refresh() {
    setState(() {
      _loading = true;
      getNews();
    });
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[
            Text('The'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
            Text('App'),
          ],
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Categories(),
            ),
            _loading ? Center(
              child: CircularProgressIndicator(),
            ) :
            Container(
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
              ],
        ),
      )
    );
  }
}