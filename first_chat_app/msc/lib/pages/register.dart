import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:msc/auth/auth_service.dart";

import "../components/my_button.dart";
import "../components/textfield.dart";

class Register extends StatelessWidget {
  void Function()? onTap;
  Register({
    super.key,
    required this.onTap,
  });
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final  TextEditingController _confirmController = TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    _pwController.dispose();
  }
  void register(BuildContext context){
    if (_pwController.text == _confirmController.text){
      try{
        final auth = AuthService();
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      }
      catch(e){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            )
        );
      }
    }
    else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Passwords don't match"),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 70.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24.0,
                ),
              ),
              MyTextField(hintText: "Email", obscureText: false, controller: _emailController,),
              const SizedBox(height: 10.0,),
              MyTextField(hintText: "Password", obscureText: true, controller: _pwController,),
              const SizedBox(height: 10.0,),
              MyTextField(hintText: "Confirm password", obscureText: true, controller: _confirmController,),
              const SizedBox(height: 25.0),
              MyButton(text: "Register", onTap: () => register(context),),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
