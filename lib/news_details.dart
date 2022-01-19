// import 'package:client_news/models/article_model.dart';
// import 'package:client_news/widgets/dynamic_image.dart';
// import 'package:flutter/material.dart';
//
// class NewsDetailTemplateOptions {
//   final ArticleModel article;
//   NewsDetailTemplateOptions(this.article);
//
// }
// class NewsDetail extends StatefulWidget {
//   final NewsDetailTemplateOptions pageOptions;
//   const NewsDetail({Key? key, required this.pageOptions}) : super(key: key);
//
//   @override
//   _NewsDetailState createState() => _NewsDetailState();
// }
//
// class _NewsDetailState extends State<NewsDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         title: Text(widget.pageOptions.article.title!,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.white
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           AspectRatio(
//             aspectRatio: 16/9,
//             child: DynamicImage(imageUrl: widget.pageOptions.article.urlToImage!,),
//           ),
//           Container(
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: 10.0,
//                 ),
//                 Text(widget.pageOptions.article.description!)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
