import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posts/main.dart';
import 'package:http/http.dart' as http;

class UpdateForm extends StatefulWidget {
  const UpdateForm({
    Key? key,
    required this.id,
    required this.body,
    required this.title,
    required this.userId,
  }) : super(key: key);
  final String id;
  final String title;
  final String body;
  final String userId;
  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController userIdEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();

  Future<void> sendPost() async {
    Post post = Post(
      id: '0',
      body: bodyEditingController.text,
      title: titleEditingController.text,
      userId: userIdEditingController.text,
    );
    var response = await http.put(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.id}',
      ),
      body: post.toJsonPost(),
      // headers: {
      //   'Content-type': 'application/json; charset=UTF-8',
      // },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Post Updated Successfluy",
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Something went wronge",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void initState() {
    titleEditingController.text = widget.title;
    bodyEditingController.text = widget.body;
    userIdEditingController.text = widget.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: 700,
        child: Column(
          children: [
            TextField(
              controller: titleEditingController,
              decoration: InputDecoration(
                label: Text("body"),
              ),
            ),
            Spacer(),
            TextField(
              controller: bodyEditingController,
              decoration: InputDecoration(
                label: Text("title"),
              ),
            ),
            Spacer(),
            TextField(
              controller: userIdEditingController,
              decoration: InputDecoration(
                label: Text("user id"),
              ),
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  sendPost();
                  Navigator.of(context).pop();
                },
                child: Text("send data "))
          ],
        ),
      ),
    );
  }
}
