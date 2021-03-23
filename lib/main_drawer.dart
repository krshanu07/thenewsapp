import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.purple,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  void _redirect(){
    StoreRedirect.redirect(
      androidAppId: 'com.developer.thenewsapp',
      iOSAppId: '',
    );
  }

  _shareText() {
    Share.share('To Read Short News Download - TheNewsApp\nhttps://play.google.com/store/apps/details?id=com.developer.thenewsapp');
  }

  @override
  Widget build(BuildContext context) {

    void _showDialog(){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialogBox(
              title: 'Info',
              content: 'TheNewsApp\nVersion - 1.0.0\n\nCredits:\n• SumitKolhe for api\n',
            );
          }
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.only(top: 100, left: 10, right: 20,),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                TextBuilder(text: 'The', color: Colors.black,),
                TextBuilder(text: 'News', color: Colors.purple,),
                TextBuilder(text: 'App', color: Colors.black,),

              ],
            )
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildListTile('Rate Us', Icons.star, _redirect),
                buildListTile('Share', Icons.share, _shareText),
                buildListTile('Info', Icons.info, _showDialog),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextBuilder extends StatelessWidget {
  final String text;
  final Color color;

  TextBuilder({@required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: color,
      ),
    );
  }
}

class AlertDialogBox extends StatelessWidget {
  final String title;
  final String content;

  AlertDialogBox({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title,style: TextStyle(fontFamily: 'Rowdies'),)),
      content: Text(
        content,
        style: TextStyle(fontFamily: 'Rowdies'),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            'Ok',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        )
      ],
    );
  }
}
