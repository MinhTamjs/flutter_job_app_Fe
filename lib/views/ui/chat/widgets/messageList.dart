import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/services/firebase_services.dart';
import 'package:jobhubv2_0/utils/date.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/loader.dart';
import 'package:jobhubv2_0/views/ui/chat/widgets/chat_left_item.dart';
import 'package:jobhubv2_0/views/ui/chat/widgets/chat_right_item.dart';

class MessageList extends StatefulWidget {
  final String chatRoomId;
  const MessageList({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  FirebaseServices _services = FirebaseServices();
  late ScrollController _msgScrolling;
  bool spacing = true;

  @override
  void initState() {
    _msgScrolling = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _msgScrolling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _messages = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: StreamBuilder<QuerySnapshot>(
        stream: _messages,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.fromSize();
          }
          if (snapshot.data?.docs.isEmpty == true) {
            return const NoSearchResults(
              text: 'Be the first to send a message',
            );
          }
          return snapshot.hasData
              ? Column(
                  children: [
                    Container(
                      height: hieght * .66,
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          // reverse: true,
                          controller: _msgScrolling,
                          itemBuilder: (BuildContext context, index) {
                            
                            var message = snapshot.data!.docs[index];

                            // var newLength = snapshot.data!.docs.length + 1;
                            Timestamp lastChatTime = message['time'];
                            DateTime lastChatDateTime = lastChatTime.toDate();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    duTimeLineFormat(lastChatDateTime),
                                    style: appStyle(
                                        10, Colors.grey, FontWeight.normal),
                                  ),
                                  message['sender'] == userUid
                                      ? ChatRightItem(
                                          message['messageType'],
                                          message['message'],
                                          message['profile'])
                                      : ChatLeftItem(
                                          message['messageType'],
                                          message['message'],
                                          message['profile']),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      height: 70,
                    )
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
