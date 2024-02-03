import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/editnews_bloc.dart';

import 'editview.dart';

class EditState extends StatefulWidget {
  final String id, title, content, date, image;
  
  EditState(
    {required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.image});

  @override
  State<EditState> createState() => _EditStateState();
}


class EditStateState extends State<EditStates> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditnewsBloc>().add(EditNewsInitialEvent()); 
    });
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditnewsBloc, EditnewsState>(builder: (context, state) {
      if (state is EditnewsInitial) {
        return EditView(
          id: widget.id, 
          judul: widget.title, 
          date: widget.date, 
          gambar: widget.image, 
          deskripsi: widget.content, 
        );
      } else if (state is LoadingEdit) {
        return Loadingwidget();
      } else if (state is SuccessEdit) {
        return Scaffold(
          appBar: AppBar(title: Text("Edit News")), 
          body: Padding(
            padding: EdgeInsets.all(16), 
            child: Column(
              children: <Widget>[
                Text(state.message), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop('reload');
                  }, 
                  child: Text("Lihat Berita"))
              ], 
            ), 
          ), 
        );
      } else if (state is ErrorEdit) {
        return ErrorNotif(message: state.message);
      } else {
        return Container(
          child: Text("Error State"), 
        ); 
      }
    });
  }
}