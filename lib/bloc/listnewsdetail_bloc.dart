import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:newscatalog/repository/news_repository.dart';

part 'listnewsdetail_event.dart';
part 'listnewsdetail_state.dart';

class ListnewsdetailBloc extends Bloc<ListnewsdetailEvent, ListnewsdetailState> {
  NewsRepository newRepository;
  ListnewsdetailBloc((required this.newsRepository)) 
      : super(LoadingNewsData()) {
    on<LoadNews> loaddata);
    on<DeleteNews> (deletenews);
  }
  
  _loadnews(LoadNews event, Emitter emit)async{
    String id = event.newsId;
    
    emit(LoadingNewsData());
    
    List res = await newsRepository.selectNews(id);
    
    if (res.isNotEmpty) {
      emit(ListnewsdetailInitial(news: res));
    }else {
      emit(FailedLoadingNewsData(message: "Gagal memuat data"));
    }
  }
  
  _deletenews(DeleteNews event, Emitter emit){
    String id = event.newsId;
    String title = event.title;
    
    Map res = await newsRepository.deleteNews(id);
    log("Dari bloc status " + res.toString());
    if (res.isNotEmpty) {
      emit(NewsDeleted(title: title));
    }else {
      emit(FailedLoadingNewsData(message: "Gagal menghapus data"));
    }
  }
}
enghapus data"));
    }
  }
}

