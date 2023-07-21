import 'package:guava/models/article.dart';
import 'package:guava/repository/article_repository.dart';
import 'package:guava/repository/preferences_repository.dart';

class Repository {
  Repository(this._articleRepository, this._preferencesRepository);
  final ArticleRepository _articleRepository;
  final PreferencesRepository _preferencesRepository;

  // BACK
  Future<List<Article>> getArticles(Object filter) async {
    String preferenceLanguage = await loadMyPreferenceLanguage();
    List<Article> articles =
        await _articleRepository.getArticles(filter, preferenceLanguage);
    return articles;
  }

  // BACK
  Future<Article> getArticle(String id) async {
    Article article = await _articleRepository.getArticle(id);
    return article;
  }

  // STORAGE
  Future<List<String>> loadMyLikedArticles() async {
    List<String> myLikedArticles =
        await _preferencesRepository.loadMyLikedArticles();
    return myLikedArticles;
  }

  // STORAGE
  Future<void> saveLikedArticle(String articleId) async {
    await _preferencesRepository.saveLikedArticle(articleId);
  }

  // STORAGE
  Future<void> unSaveLikedArticle(String articleId) async {
    await _preferencesRepository.unSaveLikedArticle(articleId);
  }

  // STORAGE
  Future<String> loadMyPreferenceLanguage() async {
    String myPreferenceLanguage =
        await _preferencesRepository.loadMyPreferenceLanguage();
    return myPreferenceLanguage;
  }

  // STORAGE
  Future<void> saveMyPreferenceLanguage(String language) async {
    await _preferencesRepository.saveMyPreferenceLanguage(language);
  }
}
