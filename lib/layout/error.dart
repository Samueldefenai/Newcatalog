import 'package:flutter/material.dart';

class ErrorNotif extends StatefulWidget {
  final String message;
  const ErrorNotif({required this.message});
  
  @override
  State<ErrorNotif> createState() => _ErrorNotifState();
}

class _ErrorNotifState extends State<ErrorNotif> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(widget.message), action: [TextButton(onPressed: () {
      Navigator.of(context).pop();
    }, child: Text("ok"))],);
  }
}