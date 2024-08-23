import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:msc/auth/auth_service.dart";
import "package:msc/components/chat_bubble.dart";
import "package:msc/components/textfield.dart";
import "package:msc/services/chat.dart";
import "package:msc/services/chat_service.dart";

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //for textField focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState(){
    super.initState();
    //add a listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus){
        // cause a delay so the keyboard has time to show up
        Future.delayed(const Duration(milliseconds: 700), () => scrollDown(),
        );
      }
    });

    // wait for listview to be built and scroll to the bottom
    Future.delayed(
      const Duration(milliseconds: 550), () => scrollDown(),
    );
  }
  @override
  void dispose(){
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();

  }

  //scrollController
final ScrollController _scrollController = ScrollController();
void scrollDown(){
_scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn);
}
  // send message
  void sendMessage() async {
//if there is something inside the text field
  if (_messageController.text.isNotEmpty){
    //send the message
    await _chatService.sendMessage(widget.receiverID, _messageController.text);

    // clear text controller
    _messageController.clear();
  }
  scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
    ),
      body: Column(
        children: [
          //display all the messages
          Expanded(
              child: _buildMessageList(),
          ),
          // display the users input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build the message list
Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    if (senderID.isNotEmpty){
      return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError){
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading..");
          }

          //return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        },
      );
    }
    else {
      return const Text("senderID was null");
    }
}

//build message item
Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  // is current user
  bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

  // align message to the right if sender is the current user, otherwise left
  var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

  if (data.isNotEmpty) {
    return Container(
        alignment: alignment,
        child: ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,
        ),
    );
  } else {
    return const Text("no data");
  }
}

//build message input
Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // textfield should take up most space
          Expanded(
              child: MyTextField(
                  hintText: "Type a message",
                  obscureText: false,
                  controller: _messageController,
                  focusNode: myFocusNode,
              ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.arrow_upward),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
}
}
