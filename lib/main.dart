import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newscatalog/bloc/addnews_bloc.dart';
import 'package:newscatalog/bloc/login_bloc.dart';
import 'package:newscatalog/repository/news_repository.dart';
import 'bloc/listnews_bloc.dart';
import 'bloc/listnewsdetail_bloc.dart';
import 'bloc/editnews_bloc.dart';

import 'repository/login_repository.dart';

//layout
import 'layout/mainstate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelesswlWidget {
  const MyAPP({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
      RepositoryProvider(create: (context) => LoginRepository()),
      RepositoryProvider(create: (context) => NewsRepository()),
      
    ], 
    child: MultiBlocProvider(
      providers: [
      BlockProvider(
        create: ((context) => LoginBloc(
          loginRepository: context.read<LoginRepository>())
        ..addd(loginInitialEvent()))),
      BlockProvider(
        create: ((context) => AddnewsBloc(
          newsRepository: context.read<NewsRepository>())
        ..addd(AddNewsInitialEvent()))), 
      BlockProvider(
        create: ((context) => ListnewsBloc(
          newsRepository: context.read<NewsRepository>())
        ..addd(TampilList()))),
      BlockProvider(
        create: ((context) => ListnewsdetailBloc(
          newsRepository: context.read<NewsRepository>()))),
      BlockProvider(
        create: ((context) => EditnewslBloc(
          newsRepository: context.read<NewsRepository>()))),
    ], 
    child: MaterialApp(
      title: "News App", 
      home: MainState(), 
    )));
  }
}