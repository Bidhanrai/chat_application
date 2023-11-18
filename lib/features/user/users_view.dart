import 'package:chat_assessment/constants/app_color.dart';
import 'package:chat_assessment/features/profile/profile_view.dart';
import 'package:chat_assessment/features/user/user_model.dart';
import 'package:chat_assessment/features/user/users_view_model.dart';
import 'package:chat_assessment/utils/extensions.dart';
import 'package:chat_assessment/utils/format_date.dart';
import 'package:chat_assessment/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class UserListView extends StackedView<UserViewModel> {
  const UserListView({super.key});

  @override
  Widget builder(BuildContext context, UserViewModel viewModel, Widget? child) {
    return StreamBuilder<QuerySnapshot<UserModel>>(
      stream: viewModel.usersListStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(child: LoadingWidget());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              _actionMenuButton(viewModel),
            ],
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 0.2, height: 0),
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              UserModel user = snapshot.data!.docs[index].data();
              return ListTile(
                onTap: () {
                  viewModel.goToChat(user.id, "${user.firstName} ${user.lastName}");
                },
                leading: CircleAvatar(
                  child: Text(user.firstName.initials().toUpperCase(), style: const TextStyle(color: lightBlack),),
                ),
                title: Text("${user.firstName} ${user.lastName}".capitalize(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                subtitle: Text("Joined: ${formatDate(user.createdAt.toDate().toIso8601String())}", maxLines: 2, overflow: TextOverflow.ellipsis,),
              );
            },
          ),
        );
      },
    );
  }

  _actionMenuButton(UserViewModel viewModel) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "profile",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProfileView()));
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, color: Colors.black,),
              SizedBox(width: 8),
              Text("Profile"),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: "sign out",
          onTap: () {
            viewModel.signOut();
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: Colors.black,),
              SizedBox(width: 8),
              Text('Sign out', style: TextStyle(),),
            ],
          ),
        ),
      ],
    );
  }

  @override
  UserViewModel viewModelBuilder(BuildContext context) => UserViewModel();
}
