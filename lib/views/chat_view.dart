import 'package:flutter/material.dart';
import 'package:group_6/core/widgets/appbar_widget.dart';
import 'package:group_6/core/widgets/chat/message_list.dart';
import 'package:group_6/core/widgets/chat/message_sender.dart';
import 'package:group_6/core/widgets/menu_widget.dart';
import 'package:group_6/model/category.dart';
import 'package:group_6/model/message.dart';
import 'package:group_6/service/message.dart';

class ChatView extends StatefulWidget {
  final Category category;

  ChatView({Key key, this.category}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Category category;

  MediaQueryData get mediaQueryData => MediaQuery.of(context);

  @override
  void initState() {
    setState(() {
      category = widget.category;
    });
    super.initState();
  }

  void onMessageSend(String messageText) {
    MessageService().sendMessage(
      category,
      Message(
        0,
        messageText,
        null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBarWidget(
        titleText: category.name,
        onPressed: () => _drawerKey.currentState.openDrawer(),
      ),
      drawer: MenuWidget(
        onCategorySelected: (category) {
          _drawerKey.currentState.openEndDrawer();
          setState(() {
            this.category = category;
          });
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: MessageList(
            category: category,
          )),
          Container(
            height: mediaQueryData.size.height * 1 / 14,
            child: MessageSender(onSend: onMessageSend),
          ),
        ],
      ),
    );
  }
}
