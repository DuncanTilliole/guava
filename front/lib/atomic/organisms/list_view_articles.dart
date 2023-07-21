import 'package:flutter/material.dart';
import 'package:guava/atomic/atoms/article_atoms.dart';
import 'package:guava/models/article.dart';

class ListViewArticles extends StatelessWidget {
  const ListViewArticles(
      {super.key,
      required this.articles,
      required this.onRefresh,
      required this.refreshFavorites});

  final List<Article> articles;
  final Function onRefresh;
  final Function refreshFavorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.55),
      child: RefreshIndicator(
          onRefresh: () async {
            return onRefresh();
          },
          child: articles.isNotEmpty
              ? (ListView.builder(
                  itemCount: articles.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final Article article = articles[index];
                    return ArticleAtoms(
                        article: article, refreshFavorites: refreshFavorites);
                  }))
              : (ListView.builder(
                  itemCount: 1,
                  padding: const EdgeInsets.only(top: 50),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text(
                        "No articles could be get ...",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  }))),
    );
  }
}
