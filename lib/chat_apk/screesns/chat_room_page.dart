// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getxdemo/chat_apk/components/bubble.dart';
import 'package:getxdemo/chat_apk/components/my_textfield.dart';
import 'package:getxdemo/chat_apk/screesns/sent_image_view.dart';
import 'package:getxdemo/chat_apk/screesns/video_player_screen.dart';
import 'package:getxdemo/chat_apk/services/auth/auth_service.dart';
import 'package:getxdemo/chat_apk/services/chat_services/chat_connecting_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatRoomPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatRoomPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
//text  controller
  final TextEditingController _messageController = TextEditingController();

//chat & auth Srevice
  final ChatConnectingServices _chatServices = ChatConnectingServices();

  final AuthService _authServices = AuthService();

// for textfiedl focus
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
// add a listener to focu node
    _focusNode.addListener(() {
      // cause a delay  so thata keyboard has time toshow up
      //then the amout of remaing space will be calculated
      // then scroll down
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

//scroll controlller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  // void sendMessage() async {
  //   // if there is something inside controller
  //   if (_messageController.text.isNotEmpty) {
  //     // send the message
  //     await _chatServices.sendMessage(
  //       widget.receiverID,
  //       _messageController.text,
  //     );
  //     // clear the controlller
  //     _messageController.clear();
  //   }
  //   scrollDown();
  // }

// send message
  void sendMessage({File? imageFile, File? videoFile}) async {
    // If a video file is provided, send it as a message
    if (videoFile != null) {
      await _chatServices.sendMessage(
        widget.receiverID,
        videoFile: videoFile,
      );
    }
    // If an image file is provided, send it as a message
    else if (imageFile != null) {
      await _chatServices.sendMessage(
        widget.receiverID,
        imageFile: imageFile,
      );
    }
    // If there is something inside controller, send it as a text message
    else if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
        widget.receiverID,
        message: _messageController.text,
      );
      _messageController.clear();
    }
    scrollDown();
  }

  Future<Uint8List> _generateThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 100,
    );
    return thumbnail!;
  }

  Widget _buildThumbnailWidget(String videoPath) {
    return FutureBuilder<Uint8List>(
      future: _generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              //width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(snapshot.data!),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); // You can return a placeholder here while the thumbnail is being generated.
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;
    // print("senderID: $senderID");
    // print("receiverID from: ${widget.receiverID}");

    return StreamBuilder(
      stream: _chatServices.getMessages(senderID, widget.receiverID),
      builder: (context, snapshot) {
        // print('Snapshot Data: ${snapshot.data}');
        if (snapshot.data == null) {
          return Center(
            child: Text("No messages"),
          );
        }
        //error
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading...."),
          );
        }
        //listview
        // return ListView(
        //   children:
        //       snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        // );
        List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
        docs.sort((b, a) {
          var aData = a.data() as Map<String, dynamic>;
          var bData = b.data() as Map<String, dynamic>;
          if (aData != null && bData != null) {
            return bData['timeStamp'].compareTo(
                aData['timeStamp']); // sort the messages based on the timeStamp
          }
          return 0;
        });
        return ListView(
          controller: _scrollController,
          children: docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // print("the data in snapshot message is ${data["message"]}");
    // print the message in the console
    bool isCurrentUser =
        data["senderID"] == _authServices.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    // return Container(
    //   alignment: alignment,
    //   child: ChatBubble(
    //     message: data["message"],
    //     isCurrentUser: isCurrentUser,
    //   ),
    // );
    return Container(
      alignment: alignment,
      child: data["videoUrl"] != null
          ? InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoApp(
                              path: data["videoUrl"],
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: 170,
                height: 230,
                // width: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 221, 250),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _buildThumbnailWidget(data["videoUrl"]),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(115, 48, 47, 47),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ]),
              ),
            )
          : data["imageUrl"] != null
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SentImageView(
                                  image: data["imageUrl"],
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 194, 221, 250),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(maxHeight: 250),
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data["imageUrl"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : ChatBubble(
                  message: data["message"],
                  isCurrentUser: isCurrentUser,
                ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    ImagePicker picker = ImagePicker();
    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        sendMessage(imageFile: imageFile);
      }
    }

    Future<void> pickVideo() async {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        File videoFile = File(pickedFile.path);
        sendMessage(videoFile: videoFile);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              focusNode: _focusNode,
              controller: _messageController,
              text: "Type a message",
              obsecureText: false,
              suffixIcon: IconButton(
                icon: Icon(Icons.attachment),
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            // color: Colors.yellow,
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () async {
                                await pickImage();
                                Navigator.pop(context);
                                // Code to pick an image
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.video_library),
                              onPressed: () async {
                                await pickVideo();
                                Navigator.pop(context);
                                // Code to pick a video
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
