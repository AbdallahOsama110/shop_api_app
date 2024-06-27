import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/api/urls.dart';
import '../../../../core/errors/failuers.dart';
import '../../../../core/utils/cache_helper.dart';
import '../models/home_data_model/home_data_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  late HomeDataModel homeDataModel;
  @override
  Future<Either<Failure, HomeDataModel>> getHomeData() async {
    try {
      final token = await CacheHelper.getData(key: 'token');
      print('token ==> $token');
      var value = await ApiService.getData(
        url: Urls.home,
        query: null,
        token: token,
        lang: 'en',
      );
      print('value status ==> ${value['status']}');
      homeDataModel = HomeDataModel.fromJson(value);
      /* homeDataModel = HomeDataModel(
        status: true,
        data: null,
      ); */
      print('homeDataModel status ==> ${homeDataModel.status}');
      return right(homeDataModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      print(e.toString());
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

/*   @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var value = await ApiService.getData(
        endPoint: 'v1/volumes',
        query: {
          'Filtering': 'free-ebooks',
          'q': 'subject:Programming',
        },
      );
      List<BookModel> books = [];

      for (var book in value['items']) {
        books.add(BookModel.fromJson(book));
      }
      print(value.toString());
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
  
  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({required String category}) async{
    try {
      var value = await ApiService.getData(
        endPoint: 'v1/volumes',
        query: {
          'Filtering': 'free-ebooks',
          'Sorting': 'relevance',
          'q': 'category:$category',
        },
      );
      List<BookModel> books = [];

      for (var book in value['items']) {
        books.add(BookModel.fromJson(book));
      }
      //print(value.toString());
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
 */
}
