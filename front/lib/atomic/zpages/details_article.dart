import 'package:flutter/material.dart';
import 'package:guava/atomic/templates/details_article.dart';
import 'package:guava/models/article.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/blocs/articles_cubit.dart';
import 'package:guava/repository/preferences_repository.dart';
import 'package:guava/repository/repository.dart';
import 'package:provider/provider.dart';

class DetailsArticlePage extends StatefulWidget {
  const DetailsArticlePage({super.key, required this.articleId});

  final String articleId;

  @override
  State<DetailsArticlePage> createState() => _DetailsArticlePageState();
}

class _DetailsArticlePageState extends State<DetailsArticlePage> {
  final Repository _repository =
      Repository(ArticleRepository(), PreferencesRepository());
  late Article article = Article("", "", "", 0, 0, "", "", "", "", "", null);
  late String preferenceLanguage = 'english';

  // Get on the WB the article we need
  void getArticle() async {
    Article response = await _repository.getArticle(widget.articleId);

    setState(() {
      article = response;
    });
  }

  void setLanguage() async {
    String response = await _repository.loadMyPreferenceLanguage();

    setState(() {
      preferenceLanguage = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getArticle();
    setLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final ArticlesCubit articlesCubit =
        Provider.of<ArticlesCubit>(context, listen: false);

    void onTapDislikeArticle() {
      articlesCubit.unSaveLikedArticle(article.id);
    }

    void onTapLikeArticle() {
      articlesCubit.saveLikedArticle(article.id);
    }

    return DetailsArticleTemplate(
        article: article,
        onTapDislikeArticle: onTapDislikeArticle,
        onTapLikeArticle: onTapLikeArticle,
        preferenceLanguage: preferenceLanguage);
  }
}
