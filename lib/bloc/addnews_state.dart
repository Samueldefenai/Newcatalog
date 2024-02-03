part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsEvent extends Equatable{}

final class AddnewsInitialEvent extends AddnewsEvent{
  @override
  List<Object> get props => [];
}

final class AddnewsLoadingState extends AddnewsEvent{
  @override
  List<Object> get props => [];
}

final class AddnewsSuccessState extends AddnewsEvent{
  @override
  List<Object> get props => [];
}

final class AddnewsErrorState extends AddnewsEvent{
  String message;
  
  AddnewsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
