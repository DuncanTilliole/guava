import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guava/atomic/templates/favorites.dart';
import 'package:guava/atomic/templates/news.dart';
import 'package:guava/atomic/templates/populars.dart';
import 'package:guava/atomic/molecules/buildPopupMenu.dart';
import 'package:guava/models/article.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/repository/preferences_repository.dart';
import 'package:guava/repository/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Repository _repository =
      Repository(ArticleRepository(), PreferencesRepository());
  late List<Article> newsArticles = [];
  late List<Article> favoritesArticles = [];
  late List<Article> popularsArticles = [];
  late String preferenceLanguage = 'english';

  // Get on the WB all the recent articles
  Future<List<Article>> getNews() async {
    List<Article> response = await _repository.getArticles({"created": "desc"});

    setState(() {
      newsArticles = response;
    });

    return response;
  }

  // Get on the Storage all the favorites articles
  void getFavorites() async {
    List<String> savedArticlesId = await _repository.loadMyLikedArticles();
    List<Article> gettingArticles = await _repository.getArticles({});

    List<Article>? savedArticles = gettingArticles
        .where((element) => savedArticlesId.contains(element.id))
        .toList();

    setState(() {
      favoritesArticles = savedArticles;
    });
  }

  // Get on the WB all the populars articles
  Future<List<Article>> getPopulars() async {
    List<Article> response = await _repository.getArticles({"views": "desc"});

    setState(() {
      popularsArticles = response;
    });

    return response;
  }

  void setLanguage() async {
    String response = await _repository.loadMyPreferenceLanguage();

    setState(() {
      preferenceLanguage = response;
    });
  }

  void onRefresh() {
    getNews();
    getFavorites();
    getPopulars();
  }

  @override
  void initState() {
    super.initState();
    setLanguage();
    getNews();
    getFavorites();
    getPopulars();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            actions: const [BuildPopupMenu()],
            title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'G',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30),
                  ),
                  Text(
                    'uava',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ])),
            leading: SvgPicture.asset('assets/images/icon.svg',
                semanticsLabel: 'Guava Logo'),
            leadingWidth: 60,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                      preferenceLanguage == 'french' ? 'Nouveautés' : 'News',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                Tab(
                    child: Text(
                        preferenceLanguage == 'french'
                            ? 'Favoris'
                            : 'Favorites',
                        style: Theme.of(context).textTheme.bodyLarge)),
                Tab(
                    child: Text(
                        preferenceLanguage == 'french'
                            ? 'Populaire'
                            : 'Populars',
                        style: Theme.of(context).textTheme.bodyLarge)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NewsTemplate(
                  articles: newsArticles,
                  onRefresh: onRefresh,
                  refreshFavorites: getFavorites),
              FavoritesTemplate(
                articles: favoritesArticles,
                onRefresh: onRefresh,
                preferenceLanguage: preferenceLanguage,
                refreshFavorites: getFavorites,
              ),
              PopularsTemplate(
                  articles: popularsArticles,
                  onRefresh: onRefresh,
                  refreshFavorites: getFavorites),
            ],
          ),
        ));
  }
}
