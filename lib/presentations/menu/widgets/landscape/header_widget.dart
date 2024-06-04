import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class HeaderWidgetLandscape extends StatelessWidget {
  const HeaderWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kedai Kawani", style: AppTextStylesBlack.headline6),
                Text("Monday, 03 Jun 2024", style: AppTextStylesBlack.body2),
              ],
            ),
            const Spacer(),
            const SizedBox(width: 24.0),
            HeaderImageWidget(state: state),
            const SizedBox(width: 16.0),
            HeaderNameWidget(state: state),
            const SizedBox(width: 24.0),
            SizedBox(
              height: 40.0,
              child: IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade50,
                ),
                icon: const Icon(
                  CupertinoIcons.settings,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HeaderImageWidget extends StatelessWidget {
  const HeaderImageWidget({super.key, required this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return (state.status.isOk)
        ? (state.authResponseModel.Data!.PhotoUrl == '' ||
                state.authResponseModel.Data!.PhotoUrl == null)
            ? CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade50,
                foregroundImage:
                    const AssetImage('assets/images/userDefaultImage.png'),
              )
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade100,
                foregroundImage:
                    NetworkImage(state.authResponseModel.Data!.PhotoUrl!),
              )
        : CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
          );
  }
}

class HeaderNameWidget extends StatelessWidget {
  const HeaderNameWidget({super.key, required this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return (state.status.isOk)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.authResponseModel.Data!.Fullname!,
                style: AppTextStylesBlack.headline6,
              ),
              Text(
                state.authResponseModel.Data!.Username!,
                style: AppTextStylesBlack.body2,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 18,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ],
          );
  }
}
