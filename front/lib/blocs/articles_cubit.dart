import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guava/repository/repository.dart';

class ArticlesCubit extends Cubit<List<String>> {
  ArticlesCubit(this._repository) : super([]);

  final Repository _repository;

  Future<void> loadMyLikedArticles() async {
    final List<String> likedArticlesId =
        await _repository.loadMyLikedArticles();
    emit(likedArticlesId);
  }

  Future<void> saveLikedArticle(String articleId) async {
    state.add(articleId);
    await _repository.saveLikedArticle(articleId);
    emit(List.of(state));
  }

  Future<void> unSaveLikedArticle(String articleId) async {
    state.remove(articleId);
    await _repository.unSaveLikedArticle(articleId);
    emit(List.of(state));
  }
}
