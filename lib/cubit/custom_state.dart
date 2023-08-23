
abstract class CustomState {}

class CustomInitial extends CustomState {}

class LoginBeginState extends CustomState {}
class LoginErrorState extends CustomState {
  final String error;
  LoginErrorState(this.error);
}
class LoginFinishedState extends CustomState {}

class RegisterBeginState extends CustomState {}
class RegisterErrorState extends CustomState {
  final String error;
  RegisterErrorState(this.error);
}
class RegisterFinishedState extends CustomState {}

class ProfileBeginState extends CustomState {}
class ProfileErrorState extends CustomState {
  final String error;
  ProfileErrorState(this.error);
}
class ProfileFinishedState extends CustomState {}

class ProductsBeginState extends CustomState {}
class ProductsFinishedState extends CustomState {}
class ProductErrorState extends CustomState {}

class ChooseImageState extends CustomState {}



