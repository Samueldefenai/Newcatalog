import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:newscatalog/repository/news_repository.dart';

part 'addnews_event.dart';
part 'addnews_state.dart';

class AddnewsBloc extends Bloc<AddnewsEvent, AddnewsState> {
  NewsRepository newsRepository;
  
  AddnewsBloc({required this.newRepository}) : super(AddnewsInitial()) {
    on<AddnewsInitialEvent>(_addnewsinitial);
    on<ClickTombolAddEvent>(_addnewsclick);
  }
  
  _addnewsinitial(AddnewsInitialEvent event, Emitter emit){
    emit(AddnewsLoadingState());
    emit(AddnewsInitial());
  }
  
  _addnewsclick(ClickTombolAddEvent event, Emitter emit) async {
    final String judul = event.title;
    final String deskripsi = event.desc;
    final String tanggal = event.date;
    final File gambar = event.image;
    emit(AddnewsLoadingState());
try {
    final result = await newsRepository.addNews(
      title: judul, desc:deskripsi, date: tanggal, image:gambar);
      emit(AddnewsSuccessState());
      await Future.delayed(Duration(seconds: 3));
      emit(AddnewsInitial());
    }catch(error){
      emit(AddnewsErrorState(message: "Error $error"));
    }
  }
}