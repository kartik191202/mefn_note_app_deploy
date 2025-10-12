import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mefn_note_app_deploy/cubit/note/note_cubit.dart';
import 'package:mefn_note_app_deploy/cubit/user/user_cubit.dart';
import 'package:mefn_note_app_deploy/ui/sign_in_page.dart';
import 'cubit/auth/auth_cubit.dart';
import 'cubit/credential/credential_cubit.dart';
import 'package:mefn_note_app_deploy/router/on_generate_route.dart';
import 'package:mefn_note_app_deploy/ui/home_page.dart';
import 'package:mefn_note_app_deploy/ui/sign_in_page.dart';
import 'package:mefn_note_app_deploy/ui/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => CredentialCubit()),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<NoteCubit>(create: (_) => NoteCubit()),
      ],
      child: MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: OnGenerateRout.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is AuthAuthenticated) {
                if (authState.uid == "") {
                  return SignInPage();
                } else {
                  return HomePage(
                    uid: authState.uid,
                  );
                }
              } else {
                return SignInPage();
              }
            });
          }
        },
      ),
    );
  }
}
