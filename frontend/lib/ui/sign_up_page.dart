import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../router/page_const.dart';
import '../ui/widgets/common/common.dart';
import '../ui/widgets/custom_button.dart';
import '../ui/widgets/custom_text_field.dart';

import '../cubit/auth/auth_cubit.dart';
import '../cubit/credential/credential_cubit.dart';
import '../models/user_model.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
          builder: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              return HomePage(uid: authState.uid);
            } else {
              return _bodyWidget();
            }
          });
        }

        return _bodyWidget();
      }, listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          context.read<AuthCubit>().loggedIn(credentialState.user.uid!);
        }
        if (credentialState is CredentialFailure) {
          showSnackBarMessage(credentialState.errorMessage, context);
        }
      }),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sign Up"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Center(
                child: Text(
              "Note App ",
              style: TextStyle(fontSize: 50),
            )),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "UserName",
              controller: _usernameController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Email",
              controller: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Sign Up",
              onTap: _submitSignUp,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Already have an account?"),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.signInPage, (route) => false);
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _submitSignUp() {
    if (_usernameController.text.isEmpty) {
      showSnackBarMessage("Please Enter UserName", context);
      return;
    }

    if (_emailController.text.isEmpty) {
      showSnackBarMessage("Please Enter Email", context);
      return;
    }

    if (_passwordController.text.isEmpty) {
      showSnackBarMessage("Please Enter Password", context);
      return;
    }

    context.read<CredentialCubit>().signUp(UserModel(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text));
  }
}
