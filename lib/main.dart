import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      allowFontScaling: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72, color: Colors.white),
            headline2: TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.w300),
            headline3: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.30,
                letterSpacing: 1.25),
            headline4: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            backgroundImageSource,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  challengeTitle(context),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.8),
                    width: answerBoxWidth,
                    height: answerBoxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(challengeTheme,
                            style: Theme.of(context).textTheme.headline4),
                        Row(
                          children: [
                            FlutterLogo(
                              size: 50,
                            ),
                            Text(
                              techText,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.8),
                    width: answerBoxWidth,
                    height: answerBoxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Yayın için kalan süre',
                            style: Theme.of(context).textTheme.headline3),
                        CountdownTimer(
                          endTime: endTime,
                          widgetBuilder: (_, time) {
                            if (time == null) {
                              return Text('Yayin Başladı', style: Theme.of(context).textTheme.headline4);
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text('${time.days}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                    Text('gün',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('${time.hours}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                    Text('saat',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('${time.min}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                    Text('dakika',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                          TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: iconHeight,
                              ),
                            ],
                          ),
                          style: ButtonStyle(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      width: answerBoxWidth,
                      child: Text('http://flutter.dev',
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    onTap: () async {
                      await canLaunch("http://flutter.dev")
                          ? await launch("http://flutter.dev")
                          : throw 'Could not launch http://flutter.dev';
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    width: answerBoxWidth,
                    child: Text('Awesome',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container challengeTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: iconHeight,
            width: iconWidth,
            color: Colors.amber,
          ),
          Text(challengeName, style: Theme.of(context).textTheme.headline3),
        ],
      ),
      width: double.infinity,
    );
  }
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
