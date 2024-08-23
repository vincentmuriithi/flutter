import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:msc/components/my_button.dart";
import "package:msc/components/textfield.dart";

import "../auth/auth_service.dart";

class Login extends StatefulWidget {
  void Function()? onTap;
  Login({
    super.key,
    required this.onTap,
  });

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  //email controller and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }
  void login(BuildContext context) async {
    final authService = AuthService();
    try{
      authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }
    catch(e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 70.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
                "Welcome you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24.0,
              ),
            ),
            MyTextField(hintText: "Email", obscureText: false, controller: _emailController,),
            const SizedBox(height: 10.0,),
            MyTextField(hintText: "Password", obscureText: true, controller: _pwController,),
            const SizedBox(height: 25.0),
            MyButton(text: "Login", onTap: () => login(context),),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "Not a member? ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.0,
              ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                      "Register now",
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
    );
  }
}
