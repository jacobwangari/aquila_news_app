import 'package:aquila_news_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl;

  const NewsCard(
      {Key? key,
      required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                imgUrl,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                // if the image is null
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Icon(Icons.broken_image_outlined),
                    ),
                  );
                },
              )),
          vertical15,
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              desc,
              maxLines: 2,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
