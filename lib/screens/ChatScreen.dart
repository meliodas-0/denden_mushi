import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denden_mushi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var user;

  User loggedInUser;
  String message;
  TextEditingController controller = TextEditingController();
  Map<String, Color> senderMapColor = {};

  void getCurrentUser() {
    user = _auth.currentUser;
    print(user);
    if (user != null) {
      loggedInUser = user;
      print(user);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> _signout() async {
    //Implement logout functionality
    await _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: _signout),
        ],
        title: ImageIcon(
          AssetImage('images/logo.png'),
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _fireStore
                      .collection('messages')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final messages = snapshot.data.docs;
                    List<MessageBubble> list = [];

                    for (var message in messages) {
                      var text = message.data()['message'];
                      var sender = message.data()['sender'];
                      bool isMe = sender == loggedInUser.email;
                      senderMapColor.putIfAbsent(sender,
                          () => isMe ? kPrimaryColor : getRandomColor());
                      list.add(MessageBubble(
                          sender: sender,
                          message: text,
                          isSenderUser: isMe,
                          color: senderMapColor[sender]));
                    }

                    return ListView(
                      children: list,
                      reverse: true,
                    );
                  },
                ),
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _fireStore.collection('messages').add({
                        'message': message,
                        'sender': loggedInUser.email,
                        'time': DateTime.now()
                      });
                      controller.clear();
                    },
                    child: Icon(
                      Icons.send,
                      size: 30,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    return colorsList[Random().nextInt(colorsList.length)];
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isSenderUser;
  final Color color;

  MessageBubble({this.message, this.sender, this.isSenderUser, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment:
            isSenderUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: color, fontSize: 12),
          ),
          Material(
            elevation: 5,
            shadowColor: isSenderUser ? Colors.pinkAccent : Colors.purpleAccent,
            borderRadius: BorderRadius.only(
              topLeft: isSenderUser ? Radius.circular(20) : Radius.zero,
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: isSenderUser ? Radius.zero : Radius.circular(20),
            ),
            color: isSenderUser ? kPrimaryColor : kTernaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: Text(
                '$message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
