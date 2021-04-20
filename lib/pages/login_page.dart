import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pemrograman_mobile_week10/models/model.dart';
import 'package:pemrograman_mobile_week10/pages/page.dart';
import 'package:pemrograman_mobile_week10/pages/register_page.dart';
import 'package:pemrograman_mobile_week10/services/authservice.dart';
import 'package:pemrograman_mobile_week10/services/sign_in.dart';
import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                                "Login",
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
                                        'Sign in with Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))),
                              onTap: () async {
                                dynamic result = await AuthServices
                                    .signInWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);

                                if (result != null) {
                                  String uid = result.email;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FirstScreen(uid: uid);
                                      },
                                    ),
                                  );
                                }
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
                _signInButton(),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: OutlineButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return RegisterPage();
              },
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.blue,
                size: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign up with Email',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            String uid = "";
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen(uid: uid);
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google-logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
