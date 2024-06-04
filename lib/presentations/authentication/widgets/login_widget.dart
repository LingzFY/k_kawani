import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/presentations/authentication/widgets/forgot_password_widget.dart';
import 'package:k_kawani/presentations/authentication/widgets/header_widget.dart';
import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:k_kawani/data/models/user_model.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    AuthRequestModel authRequestModel = AuthRequestModel.empty;
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          const HeaderWidget(),
          const SizedBox(height: 64),
          Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "username cannot be empty" : null,
                  onSaved: (newValue) => authRequestModel.Username = newValue!,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: AppTextStylesBlack.body2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "password cannot be empty" : null,
                  onSaved: (newValue) => authRequestModel.Password = newValue!,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: AppTextStylesBlack.body2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.password,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 48.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      if (validateAndSave(globalKey)) {
                        context.read<AuthBloc>().add(
                              Login(authRequestModel: authRequestModel),
                            );
                      } else {
                        showAlertDialog(
                          context,
                          Icons.warning_rounded,
                          Colors.yellow,
                          'Credentials cannot be null!',
                          'Please fill your credentials first...',
                          [
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      }
                    },
                    child: Text(
                      "Login",
                      style: AppTextStylesWhite.button,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 64),
          const ForgotPassword(),
          const Spacer(),
        ],
      ),
    );
  }

  bool validateAndSave(GlobalKey<FormState> globalKey) {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
