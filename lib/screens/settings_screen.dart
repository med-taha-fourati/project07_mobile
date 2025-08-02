import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late User user;
  Color _currentBackgroundColor = Colors.green;
  Color _currentForegroundColor = Colors.green.shade900;
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

  void _colorPicker(Color prevColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: prevColor,
              onColorChanged: (Color color) {
                setState(() {
                  prevColor = color;
                });
              },
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                  'Done',
                style: TextStyle(color: Colors.black)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/chat', arguments: user);
          }
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    _colorPicker(_currentBackgroundColor);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300
                        )
                      )
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              "Choose background color",
                            style: TextStyle(
                              fontSize: 16
                            )
                          )
                        )

                      ],
                    )
                  )
                ),

                InkWell(
                    onTap: () {
                      _colorPicker(_currentForegroundColor);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300
                                )
                            )
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "Choose foreground color",
                                    style: TextStyle(
                                        fontSize: 16
                                    )
                                )
                            )

                          ],
                        )
                    )
                ),

                InkWell(
                    onTap: () {

                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300
                                )
                            )
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "Choose API server",
                                    style: TextStyle(
                                        fontSize: 16
                                    )
                                )
                            )

                          ],
                        )
                    )
                )
              ],
            )
          )
        ]
      )
    );
  }
}
