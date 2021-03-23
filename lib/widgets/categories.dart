import 'package:flutter/material.dart';
import '../screens/category_news.dart';
import '../category_list.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // By default first one is selected
  List<Categories> category = List<Categories>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,),
      child: SizedBox(
        height: 40, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategoryItem(index),
        ),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryNews(category: categories[index].categoryName.toLowerCase())
        ));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 15, //20
          vertical: 10, //5
        ),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(
              100, // 16
            )),
        child: Text(
          categories[index].categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}