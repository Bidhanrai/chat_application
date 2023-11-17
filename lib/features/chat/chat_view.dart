import 'package:chat_assessment/features/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../constants/font_size.dart';
import '../../utils/format_date.dart';


class ChatView extends StackedView<ChatViewModel> {
  const ChatView({super.key});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat View"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50) {}
                return true;
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                padding: const EdgeInsets.all(16),
                reverse: true,
                // itemCount: viewModel.chatMessages.length,
                itemCount: 50,
                itemBuilder: (context, index) {
                  // if(viewModel.busy(viewModel.chatMessages) && index == viewModel.chatMessages.length-1) {
                  //   return const LoadingWidget();
                  // }
                  // return _chatBubble(context, viewModel.chatMessages[index], viewModel);
                  return _chatBubble(context, viewModel);
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _chatBubble(BuildContext context, MessageModel message, ChatViewModel viewModel) {
  Widget _chatBubble(BuildContext context, ChatViewModel viewModel) {
    // bool isNotYou = message.profSender!=null && message.profSender!.professionalUserId != context.read<AccountViewModel>().user?.userId
    //     || message.sender!=null && message.sender!.id != context.read<AccountViewModel>().user?.userId;
    bool isNotYou = true;

    // bool isProfessional = professionalId == context.read<AccountViewModel>().user?.userId;
    bool isProfessional = true;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isNotYou?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        isNotYou
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: !isProfessional //&& viewModel.chatModel!.professional.profileImage!=null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(""),
                      )
                    // : viewModel.chatModel!.user.profileImage!=null
                    : false
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(""),
                        )
                      : const CircleAvatar(
                          child: Text("A"),
                        ),
              )
            : const SizedBox(),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: isNotYou
                ? BorderRadius.circular(20)
                : const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: isNotYou? Colors.grey.shade200:Colors.black45,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isNotYou
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          const Expanded(child: Text("bidhan", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),)),
                          Text(isProfessional?"":"Expert", style: const TextStyle(color: Colors.black45, fontSize: s, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Text("Hey! How are you sir", style: TextStyle(color: isNotYou?Colors.black:Colors.white),),
              const SizedBox(height: 4),
              Text(formatDateInLanguageDynamic(DateTime.now().toIso8601String()), textAlign: TextAlign.end, style: TextStyle(color: isNotYou?Colors.black: Colors.grey.shade200, fontSize: s),),
            ],
          ),
        ),
      ],
    );
  }

  //
  // Widget _actionMenu(BuildContext context, ChatViewModel viewModel) {
  //   return PopupMenuButton<String>(
  //     onSelected: (String item) {
  //       if(item == "Close") {
  //         showConfirmationPopUp(
  //           // title: viewModel.chatModel!.chatDetail.chatName,
  //           // message: "Closing the chat ${viewModel.chatModel!.chatDetail.chatName}",
  //           title: "Are you sure you want to close the chat?",
  //           message: "Closing the chat ${viewModel.chatModel!.chatDetail.chatName}. You cannot undo it.",
  //           callback: () {
  //             locator<NavigationService>().goBack();
  //             viewModel.closeChat(viewModel.chatModel!.chatId);
  //           },
  //         );
  //       }
  //     },
  //     position: PopupMenuPosition.under,
  //     enabled: !viewModel.chatIsClosed(viewModel.chatModel!.user.id == context.read<AccountViewModel>().user?.userId),
  //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
  //       const PopupMenuItem<String>(
  //           value: "Close",
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(Icons.close, color: Colors.red),
  //               SizedBox(width: 10),
  //               Text('Close chat'),
  //             ],
  //           )
  //       )
  //     ],
  //
  //   );
  // }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();
}