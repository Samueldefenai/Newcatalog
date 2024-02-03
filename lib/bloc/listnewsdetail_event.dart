part of 'listnewsdetail_bloc.dart';

@immutable
sealed class ListnewsdetailEvent extends Equatable{}

class LoadNews extends ListnewsdetailEvent {
  final String newsId;
  
  LoadNews({required this.newsId});
  @override
  List<Object> get props => [];
}

class DeleteNews extends ListnewsdetailEvent {
  final String newsId;
  final String title;
  
  DeleteNews({required this.newsId, required this.title});
  
  @override
  List<Object> get props => [newsId, title];
}