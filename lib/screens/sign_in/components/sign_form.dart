import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macprojet/components/custom_surfix_icon.dart';
import 'package:macprojet/components/form_error.dart';
import 'package:macprojet/helper/keyboard.dart';
import 'package:macprojet/models/current_user.dart';
import 'package:macprojet/screens/forgot_password/forgot_password_screen.dart';
import 'package:macprojet/screens/home/home_screen.dart';
import 'package:macprojet/services/user_services.dart';
import 'package:macprojet/models/user';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void showSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "Click here",
        onPressed: () {},
      ),
    ));
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void addToprefs(String id, String email, String photo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("id", id);
    preferences.setString("email", email);
    preferences.setString("photo", photo);
    CurrentUser.email = email;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Future response = UserServices()
                    .login(new User.login(email: email!, password: password!))
                    .then((res) {
                  if (res.statusCode >= 400 && res.statusCode < 600) {
                    Map<String, dynamic> error = json.decode(res.body);
                    showSnackbar(context, error["error"]);
                  }
                  // if all are valid then go to success screen
                  if (res.statusCode == 200) {
                    Map<String, dynamic> r = json.decode(res.body);
                    CurrentUser.id = r["_id"];
                    CurrentUser.email = r["email"];
                    CurrentUser.photo = r["photo"];
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
