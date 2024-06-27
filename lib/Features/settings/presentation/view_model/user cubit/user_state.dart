part of 'user_cubit.dart';

sealed class UserStates extends Equatable {
  const UserStates();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserStates {}

final class UserloadingStates extends UserStates {}

final class GetProfileLoadingState extends UserloadingStates {}

final class GetProfileSuccessState extends UserStates {}

final class GetProfileErrorState extends UserStates {}

final class UpdateProfileLoadingState extends UserloadingStates {}

final class UpdateProfileSuccessState extends UserStates {}

final class UpdateProfileErrorState extends UserStates {}

final class GetChatLoadingState extends UserloadingStates {}

final class GetChatSuccessState extends UserStates {}

final class GetChatErrorState extends UserStates {}