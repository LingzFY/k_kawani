import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/models/user_model.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.posRepository,
  }) : super(AuthState()) {
    on<GetUser>(_mapGetUserEventToState);
    on<Login>(_mapLoginEventToState);
  }

  final PosRepository posRepository;

  void _mapGetUserEventToState(GetUser event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AuthResponseModel authResponseModel = await posRepository.getUser();

      switch (authResponseModel.Code) {
        case 200:
          authResponseModel.Data!.RawToken = prefs.getString('Token');
          emit(
            state.copyWith(
              status: AuthStatus.ok,
              authRequestModel: state.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: AuthStatus.badRequest,
              authRequestModel: state.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: AuthStatus.unauthorized,
              authRequestModel: state.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: AuthStatus.forbidden,
              authRequestModel: state.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: AuthStatus.notFound,
              authRequestModel: state.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
        ),
      );
    }
  }

  void _mapLoginEventToState(Login event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AuthResponseModel authResponseModel =
          await posRepository.postLogin(event.authRequestModel);
      switch (authResponseModel.Code) {
        case 200:
          prefs.setString('IdUser', authResponseModel.Data!.User!.Id!);
          prefs.setString('Token', authResponseModel.Data!.RawToken!);
          prefs.setBool('isActive', true);
          emit(
            state.copyWith(
              status: AuthStatus.ok,
              authRequestModel: event.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: AuthStatus.badRequest,
              authRequestModel: event.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 401:
          emit(
            state.copyWith(
              status: AuthStatus.unauthorized,
              authRequestModel: event.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: AuthStatus.forbidden,
              authRequestModel: event.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: AuthStatus.notFound,
              authRequestModel: event.authRequestModel,
              authResponseModel: authResponseModel,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
        ),
      );
    }
  }
}
