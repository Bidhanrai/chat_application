import 'package:chat_assessment/constants/font_size.dart';
import 'package:chat_assessment/utils/format_date.dart';
import 'package:chat_assessment/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${snapshot.data!.docs[0]["first name"]} ${snapshot.data!.docs[0]["last name"]}", style: const TextStyle(fontSize: xxxxxxxl, fontWeight: FontWeight.w700),),
                  Text("Email: ${snapshot.data!.docs[0]["email"]}", style: const TextStyle(fontSize: xxl, fontWeight: FontWeight.w500),),
                  Text("Joined date: ${formatDate((snapshot.data!.docs[0]["created at"] as Timestamp).toDate().toIso8601String())}", style: const TextStyle(fontSize: xxl, fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
