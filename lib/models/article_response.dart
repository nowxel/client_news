import 'package:client_news/models/article_model.dart';

class ArticleResponse {
  final List<ArticleModel> articles;
  final Object error;

  ArticleResponse(this.articles, this.error);

  ArticleResponse.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List).map((i) => ArticleModel.fromJson(i)).toList(),
        error = "";

  ArticleResponse.withError(Object errorValue)
      : articles = [],
        error = errorValue;
}