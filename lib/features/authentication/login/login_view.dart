import 'package:chat_assessment/features/authentication/login/login_view_model.dart';
import 'package:chat_assessment/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_icon_button.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTextField(
                            hintText: "Email",
                          ),
                          const SizedBox(height: 12),
                          const CustomTextField(
                            hintText: "Password",
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            label: viewModel.authState == AuthState.login?"Login":"Register",
                            onPressed: () {
                              viewModel.login();
                            },
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: [
                                Expanded(child: Divider(thickness: 0.5)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("OR", style: TextStyle(color: Colors.black),),
                                ),
                                Expanded(child: Divider(thickness: 0.5)),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                icon: const Icon(Icons.facebook, color: Colors.blueGrey, size: 36),
                                onPressed: () {},
                              ),

                              const SizedBox(width: 8),

                              CustomIconButton(
                                icon: Image.asset("assets/icons/googleIcon.png", height: 28, width: 28),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: viewModel.authState == AuthState.login?"Don't have an account?":"Already have an account?",
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => viewModel.changeAuthSate(),
                      style: const TextStyle(color: Colors.blue),
                      text: viewModel.authState == AuthState.login?" Register here": " Login here"
                    )
                  ]
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}