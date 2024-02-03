import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:newscatalog/repository/news_repository.dart';

part 'editnews_event.dart';
part 'editnews_state.dart';

class EditnewsBloc extends Bloc<EditnewsEvent, EditnewsState> {
  NewsRepository newsRepository;
  EditnewsBloc({required this.newsRepository}): super(EditnewsInitial()) { 
    on<EditnewsInitialEvent>(_editinitial);
    on<ClickEdit>(_clickedit);

 }

 _editinitial(EditNewsInitialEvent event, Emitter emit)async{
   emit(LoadingEdit());
   emit(EditnewsInitial());
 }

 _clickedit(ClickEditEvent event, Emitter emit) async {
   emit(LoadingEdit());
   
   bool result = await newsRepository.editNews(
     id: event.id,
     title: event.title,
     desc: event.content,
     date: event.date,
     image: event.image);
     
   if (result == true) {
     emit(SuccessEdit(message: "Berita" + event.title + "berhasil diubah!"));
   } else {
     emit(ErrorEdit(error: "Error edit"));
   }
 }
}