import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/modules/shop/Search/Cubic/states.dart';
import 'package:on_boarding/model/search_model.dart';
import 'package:on_boarding/shared/componnents0/Constants.dart';
import 'package:on_boarding/shared/network/End_point.dart';
import 'package:on_boarding/shared/network/remot/dio_helper.dart';

class SearchCubic extends Cubit<SearchStates> {
  SearchCubic() : super(SearchInitailState());

  static SearchCubic get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String text) {
     emit( SearchLoadingState() );
    DioHelper.postdata(url: SEARCH, data: {'text': text},token: token)
        .then((value) {
          model=SearchModel.fromJson(value.data);
          emit( SearchSuccessState() );
    })
        .catchError((error){
          print(error.toString());
          emit( SearchErrorState(error.toString()));
    });
  }
}
