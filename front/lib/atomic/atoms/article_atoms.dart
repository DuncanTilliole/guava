import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guava/atomic/zpages/details_article.dart';
import 'package:guava/blocs/articles_cubit.dart';
import 'package:guava/models/article.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleAtoms extends StatelessWidget {
  const ArticleAtoms(
      {super.key, required this.article, required this.refreshFavorites});

  final Article article;
  final Function refreshFavorites;

  @override
  Widget build(BuildContext context) {
    final String url = dotenv.env['DATABASE_URL']!;
    final ArticlesCubit articlesCubit =
        Provider.of<ArticlesCubit>(context, listen: false);

    void onTapDislikeArticle() async {
      await articlesCubit.unSaveLikedArticle(article.id);
      refreshFavorites();
    }

    void onTapLikeArticle() async {
      await articlesCubit.saveLikedArticle(article.id);
      refreshFavorites();
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsArticlePage(
              articleId: article.id,
            ),
          )),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.385,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.shadow, width: 0.4)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(url + article.image, fit: BoxFit.contain),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.025,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BlocBuilder<ArticlesCubit, List<String>>(
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
                  })
                ],
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  article.description,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                  maxLines: 2,
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
