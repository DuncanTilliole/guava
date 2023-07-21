import 'dart:convert';
import 'package:http/http.dart';
import 'package:guava/models/article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleRepository {
  final String url = dotenv.env['DATABASE_URL']!;

  Future<List<Article>> getArticles(
      Object filter, String preferenceLanguage) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "sort": jsonEncode(filter),
      "language": preferenceLanguage,
    };

    Response response = await get(
      Uri.parse('${url}articles/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<Article> articles = (jsonDecode(response.body) as List)
          .map((value) => Article.fromJsonWithoutContents(value))
          .toList();

      return articles;
    } else {
      throw Exception(
          'Status ${response.statusCode.toString()}, Failed to load addresses');
    }
  }

  Future<Article> getArticle(String id) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Response response = await get(
      Uri.parse('${url}articles/${id}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResult = jsonDecode(response.body);
      Article article = Article.fromJson(jsonResult);

      return article;
    } else {
      throw Exception(
          'Status ${response.statusCode.toString()}, Failed to load addresses');
    }
  }
}
