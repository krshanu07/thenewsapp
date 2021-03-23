import 'package:flutter/material.dart';
import '../models/news.dart';
import '../widgets/news_tile.dart';
import '../helper/news.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<NewsModel> articles = List<NewsModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  refresh(){
    setState(() {
      _loading = true;
      getCategoryNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.category.toUpperCase(),
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
            _loading ? Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
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
            )
          ],
        ),
      )
    );
  }
}
