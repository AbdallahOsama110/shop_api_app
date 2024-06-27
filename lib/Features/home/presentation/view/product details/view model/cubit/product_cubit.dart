import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);

  int activeIndex = 0;

  void activeIndicatorIndex(int index) {
    activeIndex = index;
    emit(ProductIndicatorChanged());
  }
}
