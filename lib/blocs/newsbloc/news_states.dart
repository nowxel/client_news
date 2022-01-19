import 'package:client_news/models/article_model.dart';
import 'package:equatable/equatable.dart';

class NewsStates extends Equatable{
  const NewsStates();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates{}

class NewsLoadingState extends NewsStates{}

class NewsLoadedState extends NewsStates{
  final List<ArticleModel> articleList;
  const NewsLoadedState({required this.articleList});
}

class NewsErrorState extends NewsStates{
  final Object errorMessage;
  const NewsErrorState({required this.errorMessage});
}