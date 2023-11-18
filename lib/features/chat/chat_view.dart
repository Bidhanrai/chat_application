import 'package:chat_assessment/features/chat/chat_view_model.dart';
import 'package:chat_assessment/features/chat/message_model.dart';
import 'package:chat_assessment/utils/extensions.dart';
import 'package:chat_assessment/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../constants/font_size.dart';
import '../../utils/format_date.dart';


class ChatView extends StackedView<ChatViewModel> {
  final String receiverId;
  final String receiverName;
  const ChatView({super.key, required this.receiverId, required this.receiverName});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName.capitalize()),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot<MessageModel>>(
        stream: viewModel.getMessages(receiverId),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(child: Text("Something wen wrong"),);
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          return Column(
            children: [
              Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50) {}
                    ///TODO: can implement pagination here for old chat messages
                    return true;
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 24),
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      // if(viewModel.busy(viewModel.chatMessages) && index == snapshot.data!.size-1) {
                      //   return const LoadingWidget();
                      // }
                      MessageModel message = snapshot.data!.docs[index].data();
                      return _chatBubble(context, message);
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: viewModel.messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: const TextStyle(color: Colors.black26),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: 5,
                        minLines: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: viewModel.isBusy
                          ? null
                          : () {
                        viewModel.sendMessage(receiverId, receiverName);
                      },
                      icon: viewModel.isBusy
                          ? const LoadingWidget()
                          : const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _chatBubble(BuildContext context, MessageModel message) {
    bool yourMessage = message.senderId == FirebaseAuth.instance.currentUser!.uid;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: yourMessage?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        !yourMessage
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child: Text(receiverName.initials()),
                ),
              )
            : const SizedBox(),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: yourMessage
                ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                : BorderRadius.circular(20),
            color: yourMessage? Colors.grey.shade200:Colors.blue.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              !yourMessage
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(receiverName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    )
                  : const SizedBox(),
              Text(message.message, style: TextStyle(color: yourMessage?Colors.black:Colors.white),),
              const SizedBox(height: 4),
              Text(formatDateInLanguageDynamic(message.createdAt.toDate().toIso8601String()), textAlign: TextAlign.end, style: TextStyle(color: yourMessage?Colors.black: Colors.grey.shade200, fontSize: s),),
            ],
          ),
        ),
      ],
    );
  }


  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();

  @override
  void onDispose(ChatViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.disposeController();
  }
}