import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        padding: EdgeInsets.only(
          top: 80,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    offset: new Offset(1, 2.0),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("Sign in to continue"),
                          ],
                        ),
                        ElevatedButton(
                          child: Text("Sign Up"),
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(),
                    Container(
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Esqueceu a senha?"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.black26,
                      height: 60,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              child: Text(" -- Ou --",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
