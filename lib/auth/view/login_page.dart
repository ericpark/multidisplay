import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Packages
import 'package:flutter_login/flutter_login.dart';
import 'package:multidisplay/auth/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();
  const LoginPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute<String>(
      builder: (_) => const LoginPage._(),
    );
  }

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return FlutterLogin(
            title: 'Login',
            logo: const AssetImage('assets/splash_transparent.png'),
            theme: LoginTheme(
                primaryColor: const Color(0xf0C3EFF2),
                buttonTheme: LoginButtonTheme(
                    backgroundColor: Theme.of(context).primaryColor)),
            onLogin: (LoginData data) async =>
                await context.read<AuthCubit>().login(
                      emailAddress: data.name,
                      password: data.password,
                    ),
            onSignup: _signupUser,
            loginProviders: const <LoginProvider>[
              /* LoginProvider(
                button: Buttons.google,
                label: 'Sign up with Google',
                callback: () async {
                  return null;
                },
                providerNeedsSignUpCallback: () {
                    // put here your logic to conditionally show the additional fields
      
                    return Future.value(true);
                  },
              ),*/
            ],
            onSubmitAnimationCompleted: () {
              Navigator.pop(
                  context, context.read<AuthCubit>().state.user?.id ?? "");
            },
            onRecoverPassword: _recoverPassword,
            navigateBackAfterRecovery: true,
            /*additionalSignupFields: [
                const UserFormField(
                  keyName: 'Username',
                  icon: Icon(FontAwesomeIcons.userLarge),
                ),
                const UserFormField(keyName: 'Name'),
                const UserFormField(keyName: 'Surname'),
                UserFormField(
                  keyName: 'phone_number',
                  displayName: 'Phone Number',
                  userType: LoginUserType.phone,
                  fieldValidator: (value) {
                    final phoneRegExp = RegExp(
                      '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
                    );
                    if (value != null &&
                        value.length < 7 &&
                        !phoneRegExp.hasMatch(value)) {
                      return "This isn't a valid phone number";
                    }
                    return null;
                  },
                ),
              ],*/
            userValidator: (value) {
              if (!value!.contains('@') || !value.endsWith('.com')) {
                return "Email must contain '@' and end with '.com'";
              }
              return null;
            },
            passwordValidator: (value) {
              if (value!.isEmpty) {
                return 'Password is empty';
              }
              return null;
            },
            loginAfterSignUp: true,
            //hideSignUpButton: false,
          );
        },
      ),
    );
  }
}
