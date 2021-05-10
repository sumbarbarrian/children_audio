import 'package:children_audio/views/SetupView.dart';
import 'package:children_audio/views/SetupWizard.dart';
import 'package:flutter/material.dart';

import 'global.dart';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
Global global = new Global();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MainState createState() => MainState();
}

class MainState extends State<MyApp> {
  bool isReady = false;

  @override
  void initState() {
    try {
      super.initState();
      global.after
        .then((global) {
          this.isReady = global.isReady;
          setState(() {});
        });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Audio for Children',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/setup': (context) => SetupView()
      },
    );
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!this.isReady) {
      navigatorKey.currentState!.pushNamed('/setup');
    }
  }

}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio for Children'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  global.clear();
                  navigatorKey.currentState!.pushNamed('/setup');
                },
                child: Icon(
                    Icons.more_vert
                ),
              )
          ),
        ],
      ),
      body: Center(
        child: Text('List')
      )
    );
  }
}
