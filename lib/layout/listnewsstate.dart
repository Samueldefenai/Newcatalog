import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/listnews_bloc.dart';

class ListNewsState extends StatefulWidget {
  const ListNewsState({super.key});
  
  @override
  State<ListNewsState> createState() => _ListNewsStateState();
}

class _ListNewsStateState extends State<ListNewsState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListnewsBloc, ListnewsState>(builder: (context, state){
      if (state is LoadingListnews){
        return LoadingWidget();
      } else if (state is ListNewsInitial){
        return ListNewsViews(news: state.news, searchtext: state.searchText);
      }else {
        return Container (
          child: Text("Error State"), 
        );
      }
    });
  }
}