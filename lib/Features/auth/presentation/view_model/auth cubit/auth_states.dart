abstract class AuthStates {}

abstract class LoadingState extends AuthStates {}

abstract class AuthSuccessState extends AuthStates {}

class PageIndexChanged extends AuthStates {}

class SignUpInitial extends AuthStates {}

class SignOutLoadingState extends LoadingState {}

class SignOutSuccessState extends AuthStates {
  String msg;
  SignOutSuccessState({this.msg =''});
}

class SignOutErrorState extends AuthStates {
  final String error;

  SignOutErrorState(this.error);
}

class SignUpLoading extends LoadingState {}

class SignUpSuccess extends AuthStates {
  String msg;
  SignUpSuccess({this.msg =''});
}

class SignUpError extends AuthStates {
  final String error;

  SignUpError(this.error);
}

class LoginLoading extends LoadingState {}

class LoginSuccess extends AuthSuccessState {
  String msg;
  LoginSuccess({this.msg =''});
}

class LoginError extends AuthStates {
  final String error;

  LoginError(this.error);
}

class ShowSignUpWithGoogleLoading extends LoadingState {}

class ShowSignUpWithGoogleSuccess extends AuthStates {}

class ShowSignUpWithGoogleError extends AuthStates {
  final String error;

  ShowSignUpWithGoogleError(this.error);
}

class SignUpWithGoogleLoading extends LoadingState {}

class SignUpWithGoogleSuccess extends AuthSuccessState {}

class SignUpWithGoogleError extends AuthStates {
  final String error;

  SignUpWithGoogleError(this.error);
}

class LoginWithGoogleLoading extends LoadingState {}

class LoginWithGoogleSuccess extends AuthSuccessState {}

class LoginWithGoogleError extends AuthStates {
  final String error;

  LoginWithGoogleError(this.error);
}

class CreateUserLoading extends LoadingState {}

class CreateUserSuccess extends AuthStates {}

class CreateUserError extends AuthStates {
  final String error;

  CreateUserError(this.error);
}

class SendOtpLoading extends LoadingState {}

class SendOtpSuccess extends AuthStates {}

class SendOtpError extends AuthStates {
  final String error;

  SendOtpError(this.error);
}

class ReSendOtpLoading extends LoadingState {}

class ReSendOtpSuccess extends AuthStates {}

class ReSendOtpError extends AuthStates {
  final String error;

  ReSendOtpError(this.error);
}

class VerfiyOtpLoading extends LoadingState {}

class VerfiyOtpSuccess extends AuthStates {}

class VerfiyOtpError extends AuthStates {
  final String error;

  VerfiyOtpError(this.error);
}


class CreateCustomerLoading extends LoadingState {}

class CreateCustomerSuccess extends AuthStates {}

class CreateCustomerError extends AuthStates {
  final String error;

  CreateCustomerError(this.error);
}