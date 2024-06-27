import 'package:dartz/dartz.dart';
import '../../../../core/errors/failuers.dart';
import '../models/home_data_model/home_data_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, HomeDataModel>> getHomeData();
  //Future<Either<Failure, List<BookModel>>> fetchNewestBooks();
  //Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({required String category});
}
