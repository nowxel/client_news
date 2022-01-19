import 'dart:io';

import 'package:client_news/blocs/newsbloc/news_bloc.dart';
import 'package:client_news/blocs/newsbloc/news_states.dart';
import 'package:client_news/models/article_model.dart';
import 'package:client_news/pages/search_screen.dart';
import 'package:client_news/widgets/dynamic_image.dart';
import 'package:client_news/widgets/selectable_grid_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var outputFormat = DateFormat('HH:mm');
  String imageNotAvailable = "https://www.google.com/url?sa=i&url=http%3A%2F%2Fbensca.supportwebstore.com%2FGift-Card-06292017&psig=AOvVaw15cGUsQ3Kak8c2TJ3WUMjL&ust=1642610092805000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNCLwPDdu_UCFQAAAAAdAAAAABAD";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size. height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SearchScreen(),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top:  height * 0.08
              ),
              child: BlocBuilder<NewsBloc, NewsStates>(builder: (BuildContext context, NewsStates state) {
                if (state is NewsLoadingState){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (state is NewsLoadedState){
                  List<ArticleModel> _articleList = [];
                  _articleList = state.articleList;
                  return ListView.builder(
                      itemCount: _articleList.length,
                      itemBuilder: (context, index) {
                        return _articleList.isEmpty ? Container()
                        : Container(
                            margin: EdgeInsets.only(
                              left: width * 0.02,
                              top: height * 0.01,
                              right: width * 0.02,
                              bottom: height * 0.01,
                            ),
                          child: SelectableGridCell(
                              size: 25.h,
                              childWidget: DynamicImage(
                                            imageUrl: _articleList[index].urlToImage == null
                                                ? imageNotAvailable
                                                : _articleList[index].urlToImage!,
                                          ),
                            scaleHeightFor: 0.25,
                            bottomWidget: Container(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.4),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(0.9),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(3),
                                            height: 3.h,
                                            width: 0.5.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 1.h, top: 0.5.h),
                                            child: Text(_articleList[index].title!, maxLines: 1,
                                              style: TextStyle(
                                                color:
                                                Color(0xff000000),
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                              Row(
                                                children: [
                                                  Text(
                                                    outputFormat.format(
                                                        DateTime.parse(DateFormat(
                                                                "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                                            .parse(_articleList[index]
                                                                .publishedAt!)
                                                            .toString())),
                                                    style:
                                                        TextStyle(color: Colors.grey),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () async {
                                                        if (Platform.isIOS) {
                                                          FlutterWebBrowser
                                                              .openWebPage(
                                                            url: _articleList[index]
                                                                .url!,
                                                            safariVCOptions:
                                                                SafariViewControllerOptions(
                                                              barCollapsingEnabled:
                                                                  true,
                                                              preferredBarTintColor:
                                                                  Colors.green,
                                                              preferredControlTintColor:
                                                                  Colors.amber,
                                                              dismissButtonStyle:
                                                                  SafariViewControllerDismissButtonStyle
                                                                      .close,
                                                              modalPresentationCapturesStatusBarAppearance:
                                                                  true,
                                                            ),
                                                          );
                                                        } else if (Platform
                                                            .isAndroid) {
                                                          FlutterWebBrowser
                                                              .openWebPage(
                                                            url: _articleList[index]
                                                                .url!,
                                                            customTabsOptions:
                                                                CustomTabsOptions(
                                                              colorScheme:
                                                                  CustomTabsColorScheme
                                                                      .dark,
                                                              darkColorSchemeParams:
                                                                  CustomTabsColorSchemeParams(
                                                                toolbarColor:
                                                                    Colors.deepPurple,
                                                                secondaryToolbarColor:
                                                                    Colors.green,
                                                                navigationBarColor:
                                                                    Colors.amber,
                                                                navigationBarDividerColor:
                                                                    Colors.cyan,
                                                              ),
                                                              shareState:
                                                                  CustomTabsShareState
                                                                      .on,
                                                              instantAppsEnabled:
                                                                  true,
                                                              showTitle: true,
                                                              urlBarHidingEnabled:
                                                                  true,
                                                            ),
                                                          );
                                                        } else {
                                                          await FlutterWebBrowser
                                                              .openWebPage(
                                                                  url: _articleList[
                                                                          index]
                                                                      .url!);
                                                        }
                                                      },
                                                      child: Icon(
                                                        CupertinoIcons.chevron_right,
                                                        color: Colors.grey,
                                                      )),
                                                ],
                                              ),
                                            ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          _articleList[index]
                                              .source
                                              ?.name ??
                                              "",
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.clip,
                                          style: TextStyle(
                                            color:
                                            Color(0xff000000),
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.h, top: 1.h),
                                    child: Column(
                                      children: [
                                        Text(_articleList[index].description!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                        );
                      }
                  );
                }
                else if (state is NewsErrorState) {
                  Object error = state.errorMessage;

                  return Center(
                    child: Text(error.toString()),);
                }
                else {
                  return Center(
                      child: CircularProgressIndicator());
                }
              }),
            ),
          ],
        )
      ),
    );
  }
}