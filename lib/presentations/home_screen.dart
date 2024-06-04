import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:k_kawani/data/bloc/category_bloc/category_bloc.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/data/bloc/product_bloc/product_bloc.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/authentication/login_screen.dart';
import 'package:k_kawani/presentations/menu/menu_screen_landscape.dart';
import 'package:k_kawani/presentations/order/order_screen_landscape.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:k_kawani/providers/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => PosRepository(service: PosService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                posRepository: context.read<PosRepository>(),
              )..add(GetUser()),
            ),
            BlocProvider(
              create: (context) => CategoryBloc(
                posRepository: context.read<PosRepository>(),
              )..add(GetCategories()),
            ),
            BlocProvider(
              create: (context) => ProductBloc(
                posRepository: context.read<PosRepository>(),
              )..add(GetProducts(idCategory: '')),
            ),
            BlocProvider(
              create: (context) => TransactionBloc(
                posRepository: context.read<PosRepository>(),
              )..add(GetTransactionId()),
            ),
          ],
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status.isOk) {
                Navigator.pop(context);
              } else if (state.status.isLoading) {
                showAlertDialog(context, Icons.timer_outlined, Colors.blue,
                    'Loading', 'Please wait...', []);
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
            builder: (context, state) {
              return state.status.isOk
                  ? const Row(
                      children: [
                        MenuScreenLandscape(),
                        OrderScreenLandscape(),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
