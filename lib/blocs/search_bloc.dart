// import 'package:client_news/models/article_response.dart';
// import 'package:client_news/repositories/news_repository.dart';
// import 'package:rxdart/subjects.dart';
//
// class SearchBloc {
//   final NewsRepository _repository = NewsRepository();
//   final BehaviorSubject<ArticleResponse> _subject =
//   BehaviorSubject<ArticleResponse>();
//
//   search(String value) async {
//     ArticleResponse response = await _repository.search(value);
//     _subject.sink.add(response);
//   }
//   dispose(){
//     _subject.close();
//   }
//   BehaviorSubject<ArticleResponse> get subject => _subject;
// }
// final searchBloc = SearchBloc();