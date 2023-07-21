import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Save in storage a list of liked articles
  Future<void> saveLikedArticle(String articleId) async {
    final SharedPreferences prefs = await _prefs;

    List<String> myLikedArticles = await loadMyLikedArticles();

    myLikedArticles.add(articleId);
    prefs.setStringList('likedArticles', myLikedArticles);
  }

  // Save in storage a list of liked articles
  Future<void> unSaveLikedArticle(String articleId) async {
    final SharedPreferences prefs = await _prefs;

    List<String> myLikedArticles = await loadMyLikedArticles();

    myLikedArticles.remove(articleId);
    prefs.setStringList('likedArticles', myLikedArticles);
  }

  // Get in storage all the liked articles
  Future<List<String>> loadMyLikedArticles() async {
    final SharedPreferences prefs = await _prefs;

    final List<String>? stringLikedArticles =
        (prefs.getStringList('likedArticles'));

    if (stringLikedArticles != null) {
      return stringLikedArticles;
    } else {
      return [];
    }
  }

  // Get in storage the preference language
  Future<String> loadMyPreferenceLanguage() async {
    final SharedPreferences prefs = await _prefs;

    final String? stringLikedArticles = prefs.getString('preferenceLanguage');

    if (stringLikedArticles != null) {
      return stringLikedArticles;
    } else {
      return '';
    }
  }

  // Set in storage the preference language
  Future<void> saveMyPreferenceLanguage(String preferenceLanguage) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString('preferenceLanguage', preferenceLanguage);
  }
}
