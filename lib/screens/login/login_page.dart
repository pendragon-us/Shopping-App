import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingpos/components/app_button.dart';
import 'package:shoppingpos/components/app_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> login(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: _userNameController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Done'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        print('Invalid email provided.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid email provided.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            right: -100,
            top: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Lottie.asset('images/man.json'),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Welcome back, you've been missed!",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18
                        )
                    ),
                    SizedBox(height: 30),
                    AppTextField(hintText: "Enter Username", obscureText: false, controller: _userNameController, leadingIcon: Icons.email_outlined,),
                    SizedBox(height: 20),
                    AppTextField(hintText: "Enter Password", obscureText: true, controller: _passwordController, leadingIcon: Icons.password_outlined,),
                    SizedBox(height: 20),
                    AppButton(buttonName: "LogIn", onTap: () => login(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Text(
                            "Register now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Powered by ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Text(
                      "PenDragon",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 17
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
