import 'package:chat_assessment/features/user/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserListView extends StackedView<UserViewModel> {
  const UserListView({super.key});

  @override
  Widget builder(BuildContext context, UserViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {viewModel.goToChat();},
            leading: const CircleAvatar(),
            title: const Text("Bidhan"),
            subtitle: const Text("hy"),
          );
        },
      ),
    );
  }

  @override
  UserViewModel viewModelBuilder(BuildContext context) => UserViewModel();
}
