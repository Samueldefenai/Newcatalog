part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsEvent extends Equatable{}

final class AddnewsInitialEvent extends AddnewsEvent{
  @override
  List<Object> get props => [];
}

final class ClickTombolAddEvent extends AddnewsEvent{
  final String title;
  final String desc;
  final String date;
  final File image;
  
  ClickTombolEvent(
    {required this.title, 
    required this.desc,
    required this.date,
    required this.image});
  @override
  List<Object> get props => [title, desc, date, image];
}