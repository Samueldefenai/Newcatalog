part of 'listnews_bloc.dart'

@immutable
sealed class ListnewsState extends Equatable{}

final class ListnewsInitial extends ListnewsState {
  final List news;
  final String searchText;
  
  ListnewsInitial({required this.news, this.searchText = ""});
  
  @override
  List<Object> get props => [news, searchText];
}

final class LoadingListnews extends ListnewsState {
  @override
  List<Object> get props => [];
}