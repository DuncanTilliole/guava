import 'package:flutter/material.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/repository/preferences_repository.dart';
import 'package:guava/repository/repository.dart';

class PreferenceLanguage extends StatefulWidget {
  const PreferenceLanguage({super.key});

  @override
  State<PreferenceLanguage> createState() => _PreferenceLanguageState();
}

class _PreferenceLanguageState extends State<PreferenceLanguage> {
  final Repository _repository =
      Repository(ArticleRepository(), PreferencesRepository());
  late String preferenceLanguage = 'english';

  void setLanguage() async {
    String response = await _repository.loadMyPreferenceLanguage();

    setState(() {
      preferenceLanguage = response;
    });
  }

  @override
  void initState() {
    super.initState();
    setLanguage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 1),
        Text(
          preferenceLanguage == 'french'
              ? 'Enregistrez votre langue pour continuer.'
              : 'Register your language to continuate.',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 1),
        GestureDetector(
          onTap: () async {
            await _repository.saveMyPreferenceLanguage("english");
            Navigator.of(context).pushNamed("/home");
          },
          child: Image.asset(
            'assets/images/angleterre.png',
            width: width * 0.8,
            height: height * 0.2,
            fit: BoxFit.cover,
          ),
        ),
        Spacer(flex: 1),
        GestureDetector(
          onTap: () async {
            await _repository.saveMyPreferenceLanguage("french");
            Navigator.of(context).pushNamed("/home");
          },
          child: Image.asset(
            'assets/images/france.png',
            width: width * 0.8,
            height: height * 0.2,
            fit: BoxFit.cover,
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
