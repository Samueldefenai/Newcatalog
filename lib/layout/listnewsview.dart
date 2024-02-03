import 'package:flutter/material.dart';
import '../bloc/listnews_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNewsViews extends StatefulWidget {
  final List news;
  String searchText;
  ListNewsViews({required this.news, this.searchText = ""});
  
  @override
  State<ListNewsViews> createState() => _ListNewsViewsState();
}

class _ListNewsViewsState extends State<ListNewsViews> {
  TextEditingController _search = TextEditingController();
  @override
  void initState(){
    super.initState();
    _search = TextEditingController(text: widget.searchText);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("List News"), 
      ), 
      body: Padding (
        padding: EdgeInsets.all(16.0), 
        child: Column(
          children: <Widget>[
            TextField(
              controller: _search, 
              decoration: InputDecoration(labelText: "Search News"), 
            ), 
            ElevatedButton(
              onPressed: () {
                context
                    .read<ListnewsBloc>()
                    .add(TampilList(keyword: _search.text));
              }, 
              child: Text(" Search")), 
            Expanded(child: ListView.builder(
              scrollDirection: Axis.vertical, 
              shrinkWrap: true, 
              itemCount: widget.news.length, 
              itemBuilder: (context, index){
                final Map newsItem = widget.news[index];
                
                return Card(
                  margin: EdgeInsets.all(8), 
                  child: ListTitle(
                    leading: image.network(
                      newsItem['img'],
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                     ),
                     title: Text(newsItem['title']), 
                     subtitle: Text(newsItem['date']), 
                     
                     onTap: (){
                       Navigator.push(
                         context, 
                         MaterialPageRoute(
                           builder: (context) => ListNewsDetailState(
                             id: newsItem['id']))).then((value) {
                               final search = _search_text;
                               context
                                   .read<ListnewsBloc>()
                                   .add(TampilList(keyword: _search.text));
                             });
                           
                         
                       
                       
                     }, 
                   ), 
                );
              }))
          ], 
        ), 
      ), 
    );
  }
}