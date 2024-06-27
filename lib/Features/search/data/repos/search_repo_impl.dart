/* import 'package:bookly_app/Features/Home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/Search/data/repos/search_repo.dart';
import 'package:bookly_app/consts/api_service.dart';
import 'package:bookly_app/core/errors/failuers.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepoImpl implements SearchRepo{
  @override
  Future<Either<Failure, List<BookModel>>> searchBooks({required String bookName}) async{
    try {
      var value = await ApiService.getData(
        endPoint: 'v1/volumes',
        query: {
          'Filtering': 'free-ebooks',
          'Sorting': 'relevance',
          'q': bookName,
        },
      );
      List<BookModel> books = [];

      for (var book in value['items']) {
        books.add(BookModel.fromJson(book));
      }
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

}

 */