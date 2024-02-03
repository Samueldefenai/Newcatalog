import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addnews_bloc.dart';
import 'adddataform.dart';
import 'loading.dart';
class AddState extends StatefulWidget {
  const AddState({super.key});
  
  @override
  State<AddState> createState() => _AddStateState();
}

class _AddStateState extends State<AddState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddnewsBloc, AddnewsState>(builder: (context, state) {
      if (state is AddnewsInitial) {
        return AddDataForm();
      } else if (state is AddnewsLoadingState){
        return LoadingWidget();
      } else if (state is AddnewsSuccessState) {
        return AddDataForm();
      } else if (state is AddnewsErrorState) {
        return ErrorNotif(message: state.massage);
      } else {
        return Container(
          child: Text("Error State"), 
        );
      }
    });
  }
}