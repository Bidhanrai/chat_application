import 'package:chat_assessment/constants/app_color.dart';
import 'package:chat_assessment/constants/font_size.dart';
import 'package:chat_assessment/features/authentication/login/login_view_model.dart';
import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../service/routing_service.dart';
import '../../../service/service_locator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_form_field.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                          key: viewModel.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Icon(Icons.flutter_dash, size: 60, color: Colors.blue.shade600),
                              const SizedBox(height: 12),
                              const Text(
                                "HELLO THERE",
                                style: TextStyle(
                                  fontSize: xxxxxl,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  height: 0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Welcome back, we missed you",
                                style: TextStyle(
                                  fontSize: l,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color: lightBlack,
                                  height: 0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                controller: viewModel.emailController,
                                hintText: "Email",
                                validator: (String? value) {
                                  if(value == null || value.isEmpty) {
                                    return "Add an email";
                                  } else if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              CustomTextFormField(
                                controller: viewModel.passwordController,
                                hintText: "Password",
                                obscureText: viewModel.obscurePassword,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    viewModel.showPassword();
                                  },
                                  child: Icon(viewModel.obscurePassword?Icons.visibility_off:Icons.visibility),
                                ),
                                validator: (String? value) {
                                  if(value == null || value.isEmpty) {
                                    return "Add a password";
                                  } else if(value.length<6) {
                                    return "Password must have 6 or more chars";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                isBusy: viewModel.isBusy,
                                label: "Login",
                                onPressed: viewModel.isBusy
                                    ? null
                                    : () {
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
                                    onPressed: () {
                                      viewModel.signInWithFacebook();
                                    },
                                  ),

                                  const SizedBox(width: 8),

                                  CustomIconButton(
                                    icon: Image.asset("assets/icons/googleIcon.png", height: 28, width: 28),
                                    onPressed: () {
                                      viewModel.signInWithGoogle();
                                    },
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
                      text: "Don't have an account?",
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => locator<NavigationService>().navigateTo(signUpView),
                          style: const TextStyle(color: Colors.blue),
                          text: " Register here"
                        )
                      ]
                    )
                  )
                ],
              ),
            ),
          ),
          viewModel.busy(viewModel.socialSignInBusyKey)
              ? Container(color: Colors.black38,child: const LoadingWidget())
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.disposeControllers();
  }
}