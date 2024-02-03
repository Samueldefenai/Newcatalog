part of 'listnews_bloc.dart';

@immutable
sealed class ListnewsEvent extends Equatable {}

final class TampilList extends ListnewsEvent{
  final String keyword;
  
  TampilList({this.keyword = ""});
  
  @override
  List<Object> get props => [];
}

