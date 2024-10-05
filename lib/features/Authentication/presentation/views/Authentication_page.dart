import 'package:flutter/material.dart';
import '../blocs/Authentication_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Page'),
      ),
      body: Center(
        child: Text('Welcome to the Authentication feature!'),
      ),
    );
  }
}
