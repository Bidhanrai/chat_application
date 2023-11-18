import 'package:chat_assessment/features/chat/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<MessageModel>> getMessages(String receiverId)  {
    String senderId = _firebaseAuth.currentUser!.uid;
    String conversationId = getConversationId(senderId, receiverId);
    return _firebaseFirestore
        .collection("conversation")
        .doc(conversationId)
        .collection("messages")
        .withConverter(
            fromFirestore: (snapshot, _) => MessageModel.fromJson(snapshot.data()!),
            toFirestore: (messages, _) => messages.toJson()).orderBy("createdAt", descending: true)
        .snapshots();
  }


  TextEditingController messageController = TextEditingController();

  sendMessage(String receiverId, String receiverName) async {
    if(messageController.text.trim().isEmpty) return;

    String senderId = _firebaseAuth.currentUser!.uid;
    String conversationId = getConversationId(senderId, receiverId);

    MessageModel message = MessageModel(
      receiverId: receiverId,
      message: messageController.text,
      createdAt: Timestamp.fromDate(DateTime.now()),
      receiverName: receiverName,
      senderId: senderId,
    );


    _firebaseFirestore
        .collection("conversation")
        .doc(conversationId)
        .collection("messages")
        .add(message.toJson());
    messageController.clear();
  }


  //Logic to make sure conversation id is unique for any two users chat
  String getConversationId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String conversationId = ids.join("_");
    return conversationId;
  }

  disposeController() {
    messageController.dispose();
  }
}