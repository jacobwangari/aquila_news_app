import 'package:aquila_news_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "ABOUT THE APP",
          appBar: AppBar(),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: const [
            // Image.asset('assets/images/logo.png'),
            SizedBox(height: 20),
            Text(
              'AQUILA News App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This is AQUILA news app that provides the latest news from around the world. It is built with Flutter and uses APIs to fetch and display the latest news articles.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ));
  }
}
