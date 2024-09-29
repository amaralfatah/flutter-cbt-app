import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_app/data/datasources/materi_remote_datasource.dart';
import 'package:flutter_cbt_app/data/datasources/onboarding_local_datasource.dart';
import 'package:flutter_cbt_app/data/models/responses/auth_response_model.dart';
import 'package:flutter_cbt_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_cbt_app/presentation/home/bloc/content/content_bloc.dart';
import 'package:flutter_cbt_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_cbt_app/presentation/onboarding/pages/onboarding_page.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';
import 'presentation/materi/bloc/materi/materi_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ContentBloc(),
        ),
        BlocProvider(
          create: (context) => MateriBloc(MateriRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<AuthResponseModel>(
          future: AuthLocalDatasource().getAuthData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardPage(); // Jika sudah login
            } else {
              return FutureBuilder<bool>(
                future: OnboardingLocalDatasource().getIsFirstTime(),
                builder: (context, onboardingSnapshot) {
                  if (onboardingSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    // Menampilkan loading indicator saat menunggu hasil
                    return const Center(child: CircularProgressIndicator());
                  } else if (onboardingSnapshot.hasData &&
                      onboardingSnapshot.data == true) {
                    return const OnboardingPage(); // Tampilkan onboarding
                  } else {
                    return const LoginPage(); // Tampilkan halaman login jika sudah melewati onboarding
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
