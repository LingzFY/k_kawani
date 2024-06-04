part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  ok,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  loading,
  error,
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isOk => this == AuthStatus.ok;
  bool get isBadRequest => this == AuthStatus.badRequest;
  bool get isUnauthorized => this == AuthStatus.unauthorized;
  bool get isForbidden => this == AuthStatus.forbidden;
  bool get isNotFound => this == AuthStatus.notFound;
  bool get isLoading => this == AuthStatus.loading;
  bool get isError => this == AuthStatus.error;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthRequestModel authRequestModel;
  final AuthResponseModel authResponseModel;

  AuthState({
    this.status = AuthStatus.initial,
    AuthRequestModel? authRequestModel,
    AuthResponseModel? authResponseModel,
  })  : authRequestModel = authRequestModel ?? AuthRequestModel.empty,
        authResponseModel = authResponseModel ?? AuthResponseModel.empty;

  @override
  List<Object?> get props => [status, authRequestModel, authResponseModel];

  AuthState copyWith({
    AuthStatus? status,
    AuthRequestModel? authRequestModel,
    AuthResponseModel? authResponseModel,
  }) => AuthState(
    status: status ?? this.status,
    authRequestModel: authRequestModel ?? this.authRequestModel,
    authResponseModel: authResponseModel ?? this.authResponseModel,
  );
}