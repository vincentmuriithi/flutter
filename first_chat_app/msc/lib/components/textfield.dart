import "package:flutter/material.dart";

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField(
      {
        super.key,
        required this.hintText,
        required this.obscureText,
        required this.controller,
        this.focusNode,
      }
      );
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  void get() => widget.hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary),
          ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(
             color: Theme.of(context).colorScheme.primary,
           ),
         ),
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
