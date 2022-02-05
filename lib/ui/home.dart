import 'dart:js' as js;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'code_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('json2dart_gen'),
        actions: [_buildTwitterButton(), _buildGithubButton()],
      ),
      body: const SingleChildScrollView(child: CodeSection()),
    );
  }

  IconButton _buildGithubButton() {
    return IconButton(
      onPressed: () {
        analytics.logEvent(name: 'VIEW_GITHUB');
        js.context.callMethod(
            'open', ['https://github.com/ahm3tcelik/json2dart_gen']);
      },
      icon: SvgPicture.asset(
        'assets/ic_github.svg',
        color: Colors.white,
        height: 30,
        width: 30,
      ),
      iconSize: 30,
      splashRadius: 30,
    );
  }

  IconButton _buildTwitterButton() {
    return IconButton(
      onPressed: () {
        analytics.logEvent(name: 'VIEW_TWITTER');
        js.context.callMethod('open', ['https://twitter.com/ahm3tcelik72']);
      },
      icon: SvgPicture.asset(
        'assets/ic_twitter.svg',
        color: Colors.white,
        height: 30,
        width: 30,
      ),
      iconSize: 30,
      splashRadius: 30,
    );
  }
}
