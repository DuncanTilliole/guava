import 'package:flutter/material.dart';
import 'package:guava/models/article.dart';
import 'package:guava/models/content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContainerDetailsArticle extends StatelessWidget {
  const ContainerDetailsArticle(
      {super.key, required this.article, required this.preferenceLanguage});

  final Article article;
  final String preferenceLanguage;

  @override
  Widget build(BuildContext context) {
    final String url = dotenv.env['DATABASE_URL']!;
    return Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.55),
        child: Center(
          child: article.contents == null
              ? // The article is being obtained
              (Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.scrim),
                  ),
                ))
              : // The article is here !
              (SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02)),
                      Text(
                        (preferenceLanguage == 'french'
                                ? 'Modifié le : '
                                : 'Updated : ') +
                            article.updated.substring(0, 10),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        (preferenceLanguage == 'french'
                                ? 'Auteur : '
                                : 'Author : ') +
                            article.author,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      if (article.coAuthor != null) ...[
                        Text(
                          (preferenceLanguage == 'french'
                                  ? 'Co-Auteur : '
                                  : 'Co-Author : ') +
                              article.coAuthor!,
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                      ListView.builder(
                          itemCount: article.contents?.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final Content content = article.contents![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  child: Text(content.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  child: Text(
                                    content.description,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                                if (content.image != null) ...[
                                  Image.network(url + content.image!,
                                      fit: BoxFit.contain),
                                ]
                              ],
                            );
                          }),
                    ],
                  )))),
        ));
  }
}
