import 'package:flutter/material.dart';
import 'package:netly/Components/Screens/constants.dart';
import 'package:netly/Components/Screens/strings.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
            
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100)),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.blueAccent]),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  height: 320,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(
                          child: 
                            
                            Image.asset("assets/images/user-1633249_640.png",
                            width: 100,)
                          
                        ),
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Text(
                              Strings.loginPageTitle,
                              style: Apptheme.loginPageTitle,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              SizedBox(height: 50),

              // Container For Text Field

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    color: Colors.white),
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(left: 20),
                child: TextField(
                  autocorrect: false,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email or Phone Number ",
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    icon: Icon(Icons.email_outlined),
                    contentPadding: EdgeInsets.only(left: 2),
                    border: InputBorder.none,
                  ),
                ),
              ),

              // Textfield For Password

              SizedBox(
                height: 50,
              ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    color: Colors.white),
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(left: 20),
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Password ",
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    icon: Icon(Icons.lock_outlined),
                    contentPadding: EdgeInsets.only(left: 2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: FlatButton(
                      child: Text("Forgot Password ?",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              // Login Button
              MaterialButton(
                onPressed: () {},
                child: Text("Login", style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.only(top: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
                
                textColor: Colors.white,
                elevation: 2,
                minWidth: 360,
                height: 45,
                
                color: Colors.blueAccent[700],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              // Text
              Padding(
                padding: EdgeInsets.only(right: 29),
              ),
              Text(
                "Don't have an Account ?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10
              ),
              // Create New Account Button
              FlatButton(
                onPressed: () {
                 
                },
                hoverColor: Colors.green,
                padding: EdgeInsets.only(right: 14),
                child: Text(
                  "Create New Account",
                  style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              )
              ]),
            ],
          )
        ],
      ),
    );
  }
}
