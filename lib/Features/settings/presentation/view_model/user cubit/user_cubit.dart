import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/auth/data/models/login_model.dart';
import 'package:shop_api_app/core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/consts.dart';
import 'package:crisp/crisp.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  AuthModel? authModel;
  Future<void> getProfile() async {
    try {
      emit(GetProfileLoadingState());
      final token = CacheHelper.getData(key: 'token');
      var value =
          await ApiService.getData(url: Urls.profile, token: token);
      authModel = AuthModel.fromJson(value);
      emit(GetProfileSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetProfileErrorState());
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      emit(UpdateProfileLoadingState());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.putData(
        token: token,
        url: Urls.updateProfile,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );
      authModel = AuthModel.fromJson(value.data);
      if (authModel?.status == true) {
        toastMessage(
            msg: authModel?.message ?? 'Success', type: ToastType.success);
        emit(UpdateProfileSuccessState());
      } else {
        toastMessage(
            msg: authModel?.message ?? 'something invalid',
            type: ToastType.error);
        emit(UpdateProfileErrorState());
      }
    } catch (e) {
      toastMessage(msg: e.toString(), type: ToastType.error);
      emit(UpdateProfileErrorState());
    }
  }

  late CrispMain crispMain;

  Future<void> getChat() async {
    try {
      emit(GetChatLoadingState());
      await getProfile();

      crispMain = CrispMain(
        websiteId: webId,
        locale: 'en',
        userToken: authModel?.data?.phone ?? "5511987654321",
      );

      crispMain.register(
        user: CrispUser(
          email: authModel?.data?.email ?? "leo@provider.com",
          avatar: 'https://avatars2.githubusercontent.com/u/16270189?s=200&v=4',
          nickname: authModel?.data?.name ?? "Mr.Tyson",
          phone: authModel?.data?.phone ?? "5511987654321",
        ),
      );

      crispMain.setMessage("Hello");

      crispMain.setSessionData({
        "order_id": "111",
        "app_version": "0.1.1",
      });
      emit(GetChatSuccessState());
    } catch (e) {
      emit(GetChatErrorState());
    }
  }
}
