import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/utils/stripe_service.dart';
import '../../../data/models/create_customer_model/create_customer_model.dart';
import '../../../data/models/login_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(SignUpInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  int currPageIndex = 0;
  final pageController = PageController();
  void changePageIndex() {
    if (pageController.page?.round() != currPageIndex) {
      currPageIndex = pageController.page!.round();
      emit(PageIndexChanged());
    }
  }

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final logInFormKey = GlobalKey<FormState>();
  ButtonState? logInButtonState = ButtonState.idle;

  late AuthModel logInModel;
  void userLogin() {
    emit(LoginLoading());
    ApiService.postData(
      url: Urls.login,
      data: {
        'email': emailcontroller.text,
        'password': passwordcontroller.text,
      },
    ).then((value) {
      logInModel = AuthModel.fromJson(value.data);
      if (logInModel.status) {
        emit(LoginSuccess(msg: logInModel.message ?? 'Success'));
        toastMessage(
            msg: logInModel.message ?? 'Success', type: ToastType.success);
        CacheHelper.putData(key: 'token', value: logInModel.data?.token);
      } else {
        emit(LoginError(value.data['message']));
        toastMessage(msg: value.data['message'], type: ToastType.error);
      }
    }).catchError((error) {
      emit(LoginError(error.toString()));
      toastMessage(msg: error.toString(), type: ToastType.error);
    });
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailUpController = TextEditingController();
  final TextEditingController passwordUpController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();
  ButtonState? sigUpButtonState = ButtonState.idle;

  Future<void> userSignUp() async {
    emit(SignUpLoading());
    await ApiService.postData(
      url: Urls.signUp,
      data: {
        'name': userNameController.text,
        'email': emailUpController.text,
        'phone': phoneController.text,
        'password': passwordUpController.text,
      },
    ).then((value) async {
      logInModel = AuthModel.fromJson(value.data);
      if (logInModel.status) {
        emit(SignUpSuccess(msg: logInModel.message ?? 'Success'));
        toastMessage(
            msg: logInModel.message ?? 'Success', type: ToastType.success);
        await createCustomer();
        userNameController.clear();
        emailUpController.clear();
        phoneController.clear();
        passwordUpController.clear();
      } else {
        emit(SignUpError(logInModel.message ?? 'error'));
        toastMessage(msg: logInModel.message ?? 'error', type: ToastType.error);
      }
    }).catchError((error) {
      emit(SignUpError(error.toString()));
      toastMessage(msg: error.toString(), type: ToastType.error);
    });
  }

  Future<void> createCustomer() async {
    try {
      emit(CreateCustomerLoading());
      var createCustomerModel = await StripeService.createCustomer(
        createCustomerInput: CreateCustomerModel(
          name: userNameController.text,
          email: emailUpController.text,
          phone: phoneController.text,
        ),
      );
      log('${createCustomerModel.id}');
      CacheHelper.putData(key: 'customerID', value: createCustomerModel.id);
      toastMessage(
          msg: 'customer created successfully...', type: ToastType.success);
      emit(CreateCustomerSuccess());
    } catch (e) {
      toastMessage(msg: 'incomplete checkout', type: ToastType.error);
      log(e.toString());
      emit(CreateCustomerError(e.toString()));
    }
  }
}
