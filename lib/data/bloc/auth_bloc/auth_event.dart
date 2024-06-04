part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUser extends AuthEvent {
  // GetUser({
  //   required this.authResponseModel,
  // });
  // final AuthResponseModel authResponseModel;
  // @override
  // List<Object?> get props => [authResponseModel];
}

class Login extends AuthEvent {
  Login({
    required this.authRequestModel,
  });
  final AuthRequestModel authRequestModel;
  @override
  List<Object?> get props => [authRequestModel];
}
