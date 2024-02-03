import 'package:flutter/material.dart';
import '../bloc/listnewsdetail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNewsDetailView extends StatefulWidget {
  final String id, judul, gambar, date, deskripsi;
  ListNewsDetailView(
    {required this.id, 
    required this.judul,
    required this.gambar,
    required this.date,
    required this.deskripsi});
  
  @override
  State<ListNewsDetailView> createState() => _ListNewsDetailViewState();
}

class _ListNewsDetailViewState extends State<ListNewsDetailView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.judul), 
        actions: [IconButton(
          onPressed: () {
             showoptionDialog(context).then((value) {
               if (value == 'hapus') {
                 context.read<ListnewsdetailBloc>().add(
                   DeleteNews(newsId: widget.id, title: widget.judul));
               } else if (value == 'edit') {
                 Navigator.push(
                   context, 
                   MaterialPageRoute(
                     builder: (context) => EditState(
                       id: widget.id, 
                       title: widget.judul, 
                       content: widget.deskripsi, 
                       date: widget.date, 
                       image: widget.gambar))).then(value){
                         if (value == 'reload') {
                           context
                                .read<ListnewsdetailBloc>()
                                .add(LoadNews(newsId: widget.id));
                         }
                       });
               }
             });
        }, 
        icon: Icon(Icons.more_vert))
        ],
      ), 
      body: Padding(
        padding: EdgeInsets.all(16), 
        child: Column (
          children: <Widget>[
            Text(widget.date), 
            Image.network(widget.gambar), 
            Text(widget.deskripsi)
          ], 
        ), 
      ), 
    );
  }
  
  Future showoptionDialog (BuildContext context) {
    return showDialog(
      context: context, 
      builder: (BuildContext (context) {
      return AlertDialog(
        title: Text("Kelola Data"),
        content: Text("Apa yang ingin Anda lakukan?"),
        action: [
          TextButton(onPressed: (){
            Navigator.of(context).pop('edit');
          }, child: Text("Edit")), 
          TextButton(onPressed: (){
            Navigator.of(context).pop('hapus');
          }, child: Text("Hapus")),
        ], 
      ); 
    });
  } 
}

