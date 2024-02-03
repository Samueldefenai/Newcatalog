part of 'listnewsdetail_bloc.dart';

@immutable
sealed class ListnewsdetailState extends Equatable{}

final class ListnewsdetailInitial extends ListnewsdetailState {
  final List news;
  
  ListnewsdetailInitial({required this.news});
  @override
  List<Object> get props => [];
}

final class LoadingNewsData extends ListnewsdetailState {
  @override
  List<Object> get props => [];
}

final class FailedLoadingNewsData extends ListnewsdetailState {
  final String message;
  
  FailedLoadingNewsData ({required this.message});
  @override
  List<Object> get props => [message];
}

final class NewsDeleted extends ListnewsdetailState {
  final String title;
  NewsDeleted ({required this.title});
  @override
  List<Object> get props => [title];
}