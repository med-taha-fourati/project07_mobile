import 'package:flutter/material.dart';
import 'package:project_07_chat/models/message.dart';
import '../models/user.dart';
import '../api/controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatState();
}

List<Message> messages = [

];

class _ChatState extends State<ChatScreen> {
  late User user;
  final ScrollController _controller = new ScrollController();
  final TextEditingController _textController = new TextEditingController();

  Future<void> _fetchMessages() async {
    final msgs = await ChatController.getMessages();

    setState(() {
      messages = msgs;
    });
  }

  // This gets the user sent from the /login page as an argument
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is User) {
      setState(() {
        user = args;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  void _sendMessage() async {
    if (_textController.text.trim().isEmpty) return;

    final text = _textController.text.trim();
    final success = await ChatController.sendMessage(user.id, user.username, text);

    print(success);

    if (success == 200) {
      _textController.clear();
      _fetchMessages();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send message")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("The Chat Room"),
        actions: [

        ],
      ),

        body: Column(
          children: [
            // the actual chat messages
            Expanded(
              child: Container(
                color: Colors.green.shade100,
                child: messages.isEmpty ?
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                              "( • ᴖ • ｡)",
                              style: TextStyle(fontSize: 48, color: Colors.green.shade700)
                          ),
                          Text(
                              "No messages found...",
                              style: TextStyle(fontSize: 18, color: Colors.green.shade700)
                          ),
                          Text(
                              "Be the first one to type",
                              style: TextStyle(fontSize: 18, color: Colors.green.shade700)
                          ),
                        ]
                    )
                ): ListView(
                  controller: _controller,
                  padding: EdgeInsets.all(8),
                  children: messages.map((msg) => Align(
                    alignment: (msg.username == user.username) ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: (msg.username == user.username) ? EdgeInsets.only(top: 6, bottom: 6, right: 3, left: 30) : EdgeInsets.only(top: 6, bottom: 6, right: 30, left: 3),

                      decoration: BoxDecoration(
                        color: (msg.username == user.username) ? Colors.green.shade500 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.black12,
                              offset: Offset.fromDirection(2)
                          )]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.username,
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Text(
                            msg.text
                          )
                        ],
                      )

                    )
                  )
                  ).toList()
                )
              )
              // child: Container(
              //   color: Colors.green.shade100
              // )
            ),
            Container(
              color: Colors.green.shade200,
              child:
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: _textController,
                      decoration: InputDecoration(
                        filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.transparent),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          hintText: "Type a message"
                      )
                    )
                  )
                  ),

                  IconButton.filled(
                      icon: Icon(Icons.send),
                      iconSize: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),


                    ),
                    onPressed: _sendMessage
                  )
                ]
              )
            )
            )
          ]
        )

    );
  }
}
