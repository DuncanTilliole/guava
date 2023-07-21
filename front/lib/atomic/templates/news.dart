import 'package:flutter/material.dart';
import 'package:guava/atomic/organisms/list_view_articles.dart';
import 'package:guava/models/article.dart';

class NewsTemplate extends StatelessWidget {
  const NewsTemplate(
      {super.key,
      required this.articles,
      required this.onRefresh,
      required this.refreshFavorites});

  final List<Article> articles;
  final Function onRefresh;
  final Function refreshFavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: articles.isEmpty
            ? ((Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.scrim),
                ),
              )))
            : ListViewArticles(
                articles: articles,
                onRefresh: onRefresh,
                refreshFavorites: refreshFavorites));
  }
}
