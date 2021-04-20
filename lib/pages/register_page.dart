import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pemrograman_mobile_week10/models/model.dart';
import 'package:pemrograman_mobile_week10/services/authservice.dart';
import 'package:pemrograman_mobile_week10/services/sign_in.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Model model = new Model();
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String error = "";
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign Up Email"),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 150),
                SizedBox(height: 50),
                Container(
                  child: Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 15, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, right: 14, left: 14, bottom: 8),
                              child: TextFormField(
                                validator: (value) =>
                                    EmailValidator.validate(value)
                                        ? null
                                        : "Please enter a valid email",
                                controller: emailController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(fontSize: 15),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                ),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 14, left: 14, bottom: 8),
                              child: TextFormField(
                                validator: (value) {
                                  // add your custom validation here.
                                  if (value.isEmpty) {
                                    return 'Empty Field, Please enter some text';
                                  }
                                  if (value.length < 4) {
                                    return 'Must be more than 3 charater';
                                  }
                                },
                                controller: passwordController,
                                obscureText: !model.passwordVisible,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  hintText: "Password",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        model.passwordVisible =
                                            !model.passwordVisible;
                                      });
                                    },
                                    child: Icon(
                                      model.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: model.passwordVisible
                                          ? Colors.blue
                                          : Color(0xFFE6E6E6),
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Sign Up with Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))),
                              onTap: () async {
                                await AuthServices.signUp(emailController.text,
                                    passwordController.text);
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(error),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
