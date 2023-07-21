import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/repository/preferences_repository.dart';
import 'package:guava/repository/repository.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  final Repository _repository =
      Repository(ArticleRepository(), PreferencesRepository());

  Timer _scheduleTimeout([int milliseconds = 3000]) =>
      Timer(Duration(milliseconds: milliseconds), _onNavigateHome);

  void _onNavigateHome() async {
    String preferenceLanguage = await _repository.loadMyPreferenceLanguage();

    if (preferenceLanguage != '') {
      Navigator.of(context).pushNamed("/home");
    } else {
      Navigator.of(context).pushNamed("/preference_language");
    }
  }

  @override
  void initState() {
    super.initState();
    _scheduleTimeout(1 * 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? 'assets/images/background-loader-dark.png'
                : 'assets/images/background-loader-light.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/icon.svg',
                  semanticsLabel: 'Guava Logo',
                  height: 200,
                ),
              ],
            ),
          )
        ]),
      ],
    );
  }
}
