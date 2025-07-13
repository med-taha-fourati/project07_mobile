import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
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
                color: Colors.green.shade100
              )
            ),
            Container(
              color: Colors.green.shade100,
              child:
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                          fillColor: Colors.grey.shade100,
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
