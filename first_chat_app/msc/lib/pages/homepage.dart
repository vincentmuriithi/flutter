import "package:flutter/material.dart";
import "package:msc/auth/auth_service.dart";
import "package:msc/components/mydrawer.dart";
import "package:msc/services/chat_service.dart";

import "../components/user_tile.dart";
import "chat_page.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T-Chats"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading..");
          }
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        }
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
// display all users except current user
    final currentUser = _authService.getCurrentUser();
  if (currentUser != null && userData["email"] != currentUser.email && userData["uid"] != null){
    return UserTile(
      text: userData["email"],
      onTap: () {
        // tapped on user go to chat page
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          ),
        )
        );
      },
    );
  }
  else {
    return Container();
  }
  }
}
