import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:resty/screens/home_screen.dart';
import 'package:resty/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  String _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'email',
                decoration: InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                attribute: 'password',
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _errorText,
                ),
                obscureText: true,
                maxLines: 1,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  // FormBuilderValidators.email(context),
                ]),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text("Login"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  setState(() => _errorText = null);
                  if (_fbKey.currentState.saveAndValidate()) {
                    try {
                      await AuthService.login(_fbKey.currentState.value);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    } catch (e) {
                      setState(() => _errorText = e is DioError ? e.error : e.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
