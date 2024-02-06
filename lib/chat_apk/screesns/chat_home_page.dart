// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getxdemo/chat_apk/components/user_tile.dart';
import 'package:getxdemo/chat_apk/screesns/chat_room_page.dart';
import 'package:getxdemo/chat_apk/services/auth/auth_service.dart';
import 'package:getxdemo/chat_apk/components/my_drawer.dart';
import 'package:getxdemo/chat_apk/services/chat_services/chat_connecting_services.dart';

class ChatHomePage extends StatelessWidget {
  ChatHomePage({super.key});
  final ChatConnectingServices _chatServices = ChatConnectingServices();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Chat Home Page'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        //errror
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text("No user found"),
          );
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //return listview
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //navigate to chat screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        color: Colors.red,
      ); // return empty container
    }
  }
}
