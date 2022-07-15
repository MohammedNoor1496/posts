import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posts/main.dart';
import 'package:http/http.dart' as http;

class FormData extends StatefulWidget {
  const FormData({Key? key}) : super(key: key);

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
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
    var response = await http.post(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
      body: post.toJsonPost(),
      // headers: {
      //   'Content-type': 'application/json; charset=UTF-8',
      // },
    );

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: "Post Created Successfluy",
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
