import 'package:flutter/material.dart';
import 'package:project_07_chat/models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatState();
}

List<Message> messages = [

];

class _ChatState extends State<ChatScreen> {
  final ScrollController _controller = new ScrollController();
  final TextEditingController _textController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
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
                    alignment: (msg.username == "trbsh") ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: (msg.username == "trbsh") ? EdgeInsets.only(top: 6, bottom: 6, right: 3, left: 30) : EdgeInsets.only(top: 6, bottom: 6, right: 30, left: 3),

                      decoration: BoxDecoration(
                        color: (msg.username == "trbsh") ? Colors.green.shade500 : Colors.grey.shade200,
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
                    onPressed: () {}
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
