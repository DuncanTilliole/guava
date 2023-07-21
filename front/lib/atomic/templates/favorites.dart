import 'package:flutter/material.dart';
import 'package:guava/atomic/organisms/list_view_articles.dart';
import 'package:guava/models/article.dart';

class FavoritesTemplate extends StatelessWidget {
  const FavoritesTemplate({
    super.key,
    required this.articles,
    required this.onRefresh,
    required this.preferenceLanguage,
    required this.refreshFavorites,
  });

  final List<Article> articles;
  final Function onRefresh;
  final String preferenceLanguage;
  final Function refreshFavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: articles.isEmpty
            ? ((Align(
                alignment: Alignment.center,
                child: Text(
                  preferenceLanguage == 'french'
                      ? "Vous n'avez pas d'articles favoris."
                      : "You don't have favorite articles,\nYou can add an article when you click on the like guava...",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              )))
            : ListViewArticles(
                articles: articles,
                onRefresh: onRefresh,
                refreshFavorites: refreshFavorites));
  }
}
