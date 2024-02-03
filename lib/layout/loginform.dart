import 'package:flutter/material.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});
  
  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, 
      ),
      body: Padding (
        padding: EdgeInsets.all(16.0),
      child: Column( 
        children: <Widget>[
          TextField(
            controller: _usernameController, 
            decoration: InputDecoration(labelText: "Isi Username"), 
          ),
          TextField(
            controller: _passwordController, 
            decoration: InputDecoration(labelText: "Isi Password"), 
            obscureText: true, 
          ), 
          SizeBox(
            height: 16,
          ), 
          ElevatedButton(
            onPressed: (){
              final username = _usernameController.text;
              final password = _passwordController.text;
              
              context.read<LoginBloc>().add(ProsesLogin(username: username, password: password));
            }, 
          child: Text(" Login"))
        ], 
      )));
  }
}