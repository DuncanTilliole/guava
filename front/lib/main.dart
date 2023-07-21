import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guava/atomic/zpages/home.dart';
import 'package:guava/atomic/zpages/loader.dart';
import 'package:guava/atomic/zpages/preference_language.dart';
import 'package:guava/blocs/articles_cubit.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/repository/preferences_repository.dart';
import 'package:guava/repository/repository.dart';
import 'package:guava/theme/app_theme_light.dart';
import 'package:guava/theme/app_theme_dark.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ----------------- FIREBASE BEGIN
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ----------------- FIREBASE END

  // ----------------- ENV
  await dotenv.load(fileName: "assets/env/.env");

  // ----------------- APPLICATION REPOSITORY, CUBIT
  final ArticleRepository articleRepository = ArticleRepository();
  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final Repository repository =
      Repository(articleRepository, preferencesRepository);

  final ArticlesCubit articlesCubit = ArticlesCubit(repository);
  articlesCubit.loadMyLikedArticles();

  runApp(MultiProvider(
    providers: [
      Provider<ArticlesCubit>(create: (_) => articlesCubit),
      Provider<Repository>(create: (_) => repository),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guava Application',
        home: const LoaderPage(),
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: {
          '/home': (context) => const HomePage(),
          '/preference_language': (context) => const PreferenceLanguage(),
        });
  }
}
