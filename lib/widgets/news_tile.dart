import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thenewsapp/screens/news_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class NewsTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String desc;
  final String source;
  final int timeStamp;
  final String url;

  NewsTile(
      {@required this.title,
      @required this.imageUrl,
      @required this.desc,
      @required this.source,
      @required this.timeStamp,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    var date = timeStamp;
    var newDate = DateTime.fromMicrosecondsSinceEpoch(date * 1000);

    String timeAgo(DateTime d) {
      Duration diff = DateTime.now().difference(d);
      if (diff.inDays > 365)
        return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      if (diff.inDays > 30)
        return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      if (diff.inDays > 7)
        return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      if (diff.inDays > 0)
        return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
      if (diff.inHours > 0)
        return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
      if (diff.inMinutes > 0)
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "min"} ago";
      return "just now";
    }

    // Future<void> _shareText() async {
    //   try {
    //     Share.text(title, '*$title*\n$desc\n\n*Source:* $source\n\n@TheNewsApp',
    //         'text/plain');
    //   } catch (e) {
    //     print('error: $e');
    //   }
    // }

    void share() async {
        final response = await get(imageUrl);
        final bytes = response.bodyBytes;
        final Directory temp = await getTemporaryDirectory();
        final File imageFile = File('${temp.path}/tempImage.jpg');
        print(imageFile);
        imageFile.writeAsBytesSync(bytes);
        Share.shareFiles(['${temp.path}/tempImage.jpg'], text: '*$title*\n$desc\n\n*Source:* $source\n\n@TheNewsApp');
        print('${temp.path}');
      }

    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewsView(
                        url: url,
                      )));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      ),
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      title.trim(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 0, right: 8),
                    child: Text(
                      desc,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Theme.of(context).accentColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              timeAgo(newDate),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
//                          Icon(Icons.search, color: Theme.of(context).accentColor),
                            Text(
                              source,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.share),
                              color: Theme.of(context).accentColor,
                              onPressed: share,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
