import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/app_color.dart';
import '../../../constants/font_size.dart';
import '../../../service/navigation_service.dart';
import '../../../service/routing_service.dart';
import '../../../service/service_locator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'signup_view_model.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({super.key});

  @override
  Widget builder(BuildContext context, SignUpViewModel viewModel, Widget? child) {
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
                      key: viewModel.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "HELLO THERE",
                            style: TextStyle(
                              fontSize: xxxxxl,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Register below with your details!",
                            style: TextStyle(
                                fontSize: l,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: lightBlack
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          CustomTextFormField(
                            controller: viewModel.firstNameController,
                            hintText: "First name",
                            validator: (String? value) {
                              if(value == null || value.isEmpty) {
                                return "Cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          CustomTextFormField(
                            controller: viewModel.lastNameController,
                            hintText: "Last name",
                            validator: (String? value) {
                              if(value == null || value.isEmpty) {
                                return "Cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 12),
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
                          const SizedBox(height: 12),
                          CustomTextFormField(
                            controller: viewModel.confirmPasswordController,
                            hintText: "Confirm password",
                            obscureText: viewModel.obscurePassword,
                            suffixIcon: InkWell(
                              onTap: () {
                                viewModel.showPassword();
                              },
                              child: Icon(viewModel.obscurePassword?Icons.visibility_off:Icons.visibility),
                            ),
                            validator: (String? value) {
                              if(value == null || value.isEmpty) {
                                return "Cannot be empty";
                              } else if(viewModel.passwordController.text != value) {
                                return "Confirm password didn't match";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            isBusy: viewModel.isBusy,
                            label: "Register",
                            onPressed: viewModel.isBusy
                                ? null
                                : () {
                              viewModel.register();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                    text: "Already have an account?",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => locator<NavigationService>().navigateTo(loginView),
                        style: const TextStyle(color: Colors.blue),
                        text: " Login here",
                      ),
                    ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();

  @override
  void onDispose(SignUpViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.disposeControllers();
  }
}