
import 'package:exp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
enum EmailFormType{signIn, register}
class EmailForm extends StatefulWidget {
  EmailForm({required this.auth});
  final AuthBase auth;
  @override
  _EmailFormState createState() => _EmailFormState();
}
class _EmailFormState extends State<EmailForm> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  String get _email => _email_controller.text;
  String get _password => _password_controller.text;
  EmailFormType _formType = EmailFormType.signIn;
  void submit() async {
    try {
      if (_formType == EmailFormType.signIn) {
        await widget.auth.signInWithEmail(email: _email, password: _password);
      } else {
        await widget.auth.signUpWithEmail(email: _email, password: _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }

  }
  void _toggleFormType(){
    setState(() {
      _formType = _formType == EmailFormType.signIn
          ? EmailFormType.register
          : EmailFormType.signIn;
    });
    _email_controller.clear();
    _password_controller.clear();
  }
  List<Widget> _buildChildren(){
    final primaryText = _formType == EmailFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
    final secondaryText = _formType == EmailFormType.signIn
        ? 'New to Lepic? Register'
        : 'Have an Account ? Sign In';
    return [
      TextField(
        controller: _email_controller,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _password_controller,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      ElevatedButton(onPressed: submit,
          child: Text(primaryText),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.orange;
                return Colors.white; // Use the component's default.
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )
            )
        ),
      ),
      SizedBox(height: 8.0),
      TextButton(onPressed: _toggleFormType,
        child: Text(secondaryText),
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),

    );
  }
}
