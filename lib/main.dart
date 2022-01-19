import 'package:client_news/blocs/newsbloc/news_bloc.dart';
import 'package:client_news/blocs/newsbloc/news_states.dart';
import 'package:client_news/pages/splash_screen.dart';
import 'package:client_news/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (_, __, ___) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NewsBloc>(
                create: (context) => NewsBloc(
                    initialState: NewsInitState(),
                    newsRepository: NewsRepository()))
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          ),
        );
      }
    );
  }
}

