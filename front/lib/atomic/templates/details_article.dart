import 'package:flutter/material.dart';
import 'package:guava/atomic/organisms/container_details_article.dart';
import 'package:guava/models/article.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guava/blocs/articles_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsArticleTemplate extends StatelessWidget {
  const DetailsArticleTemplate({
    super.key,
    required this.article,
    required this.onTapDislikeArticle,
    required this.onTapLikeArticle,
    required this.preferenceLanguage,
  });

  final Article article;
  final Function onTapDislikeArticle;
  final Function onTapLikeArticle;
  final String preferenceLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              article.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              if (article.contents != null) ...[
                Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: BlocBuilder<ArticlesCubit, List<String>>(
                        builder: (context, articlesId) {
                      if (articlesId.contains(article.id)) {
                        return GestureDetector(
                          onTap: () => onTapDislikeArticle(),
                          child: SvgPicture.asset(
                            'assets/images/icon-like.svg',
                            semanticsLabel: 'Icon',
                            height: 40,
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () => onTapLikeArticle(),
                          child: SvgPicture.asset(
                            'assets/images/icon-dislike.svg',
                            semanticsLabel: 'Icon',
                            height: 40,
                          ),
                        );
                      }
                    }))
              ]
            ],
            titleSpacing: 0,
            leadingWidth: 60),
        body: ContainerDetailsArticle(
          article: article,
          preferenceLanguage: preferenceLanguage,
        ));
  }
}
