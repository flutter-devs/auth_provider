import 'package:flutter/material.dart';
import 'package:flutter_chat_app/enum/appState.dart';
import 'package:flutter_chat_app/model/authModel.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthModel authModel;

  AuthPage({
    @required this.emailController,
    @required this.passwordController,
    @required this.authModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailController,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              authModel.viewState == ViewState.Busy
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      child: Text(authModel.authState == AuthState.SignIn
                          ? "Sign In"
                          : "Sign Up"),
                      color: Colors.cyanAccent,
                      onPressed: () {
                        authModel.authState == AuthState.SignIn
                            ? authModel.signIn(
                                emailController.text,
                                passwordController.text,
                              )
                            : authModel.createNewUser(
                                emailController.text,
                                passwordController.text,
                              );
                      }),
              InkWell(
                onTap: () {
                  authModel.authState == AuthState.SignIn
                      ? authModel.setAuthState(AuthState.SignUp)
                      : authModel.setAuthState(AuthState.SignIn);
                },
                child: Text(authModel.authState == AuthState.SignIn
                    ? "Create account ??"
                    : "Already registered ??"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
