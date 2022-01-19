import 'package:client_news/models/article_model.dart';
import 'package:client_news/models/article_response.dart';
import 'package:client_news/widgets/dynamic_image.dart';
import 'package:client_news/widgets/text_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final Function(String input)? onSearchFieldChanged;

  var outputFormat = DateFormat('HH:mm');

  final _searchController = TextEditingController();

  List<ArticleModel> totalUsers = List.empty();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   searchBloc.search("");
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TextInputField(
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: CupertinoColors.systemGrey,
              size: 24,
            ),
            defaultBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            onChanged: (value){
              onSearchFieldChanged?.call(value);
            },
            isValid: false,
            hintText: '',
            isLoading: false,
            labelText: 'Search',
          ),
        ),
        // Expanded(child: StreamBuilder<ArticleResponse>(
        //   stream: getTopHeadlinesBloc.subject.stream,
        //   builder: (context, AsyncSnapshot<ArticleResponse> snapshot){
        //     if(snapshot.hasData) {
        //       if(snapshot.data?.error.toString() !=null
        //           // &&
        //           // snapshot.data?.length! > 0
        //       ){
        //         return buildErrorWidget(snapshot.data!.error);
        //       }
        //       return _buildSearchedNews(snapshot.data!);
        //     } else if (snapshot.hasError) {
        //       return buildErrorWidget(snapshot.data!.error);
        //     } else {
        //       return buildLoadingWidget();
        //     }
        //   },
        // ))
      ],
    );
  }
  Widget _buildSearchedNews (ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if(articles.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("No Articles"),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              // Navigator.push(
              //     context, MaterialPageRoute(
              //     builder: (context) =>
              //         NewsDetail(
              //             pageOptions: NewsDetailTemplateOptions(
              //                 articles[index]))));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.0
                  )
                ),
                color: Colors.white
              ),
              height: 150.0,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: Column(
                      children: [
                        Text(articles[index].title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14
                        ),),
                        Expanded(child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(outputFormat.format(
                              DateTime.parse(DateFormat(
                                  "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                  .parse(articles[index]
                                  .publishedAt!)
                                  .toString())),
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 10.0
                    ),
                    width: MediaQuery.of(context).size.width * 2 / 5,
                    height: 130.0,
                    child: DynamicImage(imageUrl: articles[index].urlToImage),
                  )
                ],
              ),
            ),
          );
        }
      );
    }
  }
}
