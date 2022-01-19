import 'dart:convert';

import 'package:client_news/constants/strings.dart';
import 'package:client_news/models/article_model.dart';
import 'package:client_news/models/article_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  // static String mainUrl = "https://newsapi.org/v2/";
  // final String apiKey = "b4b1fb616ee54a9cb5040a77cd1b352a";
  //
  // final Dio _dio = Dio();
  //
  // var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  
  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(Uri.parse(Strings.newsUrl));

    var data = jsonDecode(response.body);

    List<ArticleModel> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]){
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList.add(_articleModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList;
    }
  }

//   Future<ArticleResponse> getTopHeadlines() async {
//     var params = {
//       "apiKey": apiKey,
//       "country": "ua"
//     };
//
//   try{
//     Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
//     return ArticleResponse.fromJson(response.data);
//   } catch (error) {
//     return ArticleResponse.withError(error);
//   }
// }
//
//   Future<ArticleResponse> search(String searchValue) async {
//     var params = {
//       "apiKey" : apiKey,
//       "q": searchValue
//     };
//
//     try{
//       Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
//       return ArticleResponse.fromJson(response.data);
//     } catch (error) {
//       return ArticleResponse.withError(error);
//     }
//   }
}