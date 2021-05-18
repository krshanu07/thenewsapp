import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class News {
  List<NewsModel> news = [];

  Future<void> getNews() async{
    String url = 'https://inshortsv2.vercel.app/news?type=all_news&limit=50';
    
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(response.statusCode == 200) {
      jsonData['articles'].forEach((element){
        if(element['image_url'] != null && element['description'] != null){
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            url: element['source_url'],
            imageUrl: element['image_url'],
            source: element['source_name'],
            timestamp: element['created_at'],
          );
          news.add(newsModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<NewsModel> news = [];

  Future<void> getNews(String category) async {
    String url = 'https://inshortsv2.vercel.app/news?type=$category&limit=20';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jsonData['articles'].forEach((element) {
        if (element['image_url'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            url: element['source_url'],
            imageUrl: element['image_url'],
            source: element['source_name'],
            timestamp: element['created_at'],
          );
          news.add(newsModel);
        }
      });
    }
  }
}

class TrendingNewsClass {
  List<NewsModel> news = [];

  Future<void> getNews(topic) async {
    String url = 'https://inshortsv2.vercel.app/news/$topic/100';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jsonData['articles'].forEach((element) {
        if (element['image_url'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            url: element['source_url'],
            imageUrl: element['image_url'],
            source: element['source_name'],
            timestamp: element['created_at'],
          );
          news.add(newsModel);
        }
      });
    }
  }
}
