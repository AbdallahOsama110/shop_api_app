import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/search/data/models/search_model/search_model.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/utils/cache_helper.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  Future<void> searchProduct({required String text}) async {
    try {
      emit(SearchLoading());
      final token = await CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.search,
        data: {
          'text': text,
        },
      );
      print('Search value status ==> ${value.data['status']}');
      searchModel = SearchModel.fromJson(value.data);
      print('searchModel status ==> ${searchModel?.status}');
      emit(SearchSuccess());
    } catch (e) {
      if (e is DioException) {
        emit(SearchFailure());
      }
      print(e.toString());
      emit(SearchFailure());
    }
  }
}
