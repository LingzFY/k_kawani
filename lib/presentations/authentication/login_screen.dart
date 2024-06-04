import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/presentations/authentication/widgets/login_widget.dart';
import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/home_screen.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:k_kawani/providers/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RepositoryProvider(
            create: (context) => PosRepository(service: PosService()),
            child: BlocProvider(
              create: (context) =>
                  AuthBloc(posRepository: context.read<PosRepository>()),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status.isOk) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.check_circle_outline_outlined,
                      Colors.green,
                      'Ok!',
                      'Login Successfully...',
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                    // debugPrint(state.authResponseModel.toJson());
                    // Remove all routes below the pushed route and go to home screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  } else if (state.status.isBadRequest) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.orangeAccent,
                      'Bad Request!',
                      state.authResponseModel.Message!,
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  } else if (state.status.isUnauthorized) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.orangeAccent,
                      'Unauthorized!',
                      state.authResponseModel.Message!,
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  } else if (state.status.isForbidden) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.orangeAccent,
                      'Forbidden!',
                      state.authResponseModel.Message!,
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  } else if (state.status.isNotFound) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.orangeAccent,
                      'Not Found!',
                      state.authResponseModel.Message!,
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  } else if (state.status.isError) {
                    Navigator.pop(context);
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.red,
                      'Something Was Wrong!',
                      'Try again later...',
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  } else if (state.status.isLoading) {
                    showAlertDialog(context, Icons.timer_outlined, Colors.blue,
                        'Loading', 'Please wait...', []);
                  }
                },
                child: const LoginWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
