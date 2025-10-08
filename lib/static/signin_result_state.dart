import 'package:lokakarya/data/model/user.dart';

sealed class SignInResultState {}

class SignInNoneState extends SignInResultState {}

class SignInLoadingState extends SignInResultState {}

class SignInErrorState extends SignInResultState {
  final String error;

  SignInErrorState(this.error);
}

class SignInSuccessState extends SignInResultState {
  final User user;

  SignInSuccessState(this.user);
}