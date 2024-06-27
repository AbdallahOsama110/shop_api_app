import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  bool isLast = false;
  void onChangePageView(int index, lastIndex) {
    if (index == lastIndex) {
      isLast == true;
      emit(OnboardingIsLast());
      print('is Last');
    } else {
      isLast == false;
      emit(OnboardingIsNotLast());
      print('is Not Last');
    }
  }
}
