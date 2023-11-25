// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSuffixIconTapped;
  final bool showReplayButton;
  bool obscureText;
  String hintTextt;

  CustomTextField({
    Key? key,
    required this.controller,
    this.onSuffixIconTapped,
    this.showReplayButton = false,
    this.obscureText = true,
    required this.hintTextt,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void _generateRandomPassword() {
    // Define the characters you want to include in the password
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';

    // Use the Random class to generate a random password
    String password = '';
    Random random = Random();
    for (int i = 0; i < 8; i++) {
      int index = random.nextInt(characters.length);
      password += characters[index];
    }

    // Set the generated password in the TextField
    widget.controller.text = password;
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(12),
        height: 70,
        width: double.infinity,
        color: Color.fromARGB(255, 218, 238, 255),
        child: TextField(
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.showReplayButton
                ? IconButton(
                    icon: Icon(Icons.replay),
                    onPressed: _generateRandomPassword,
                  )
                : null,
            suffixIcon: widget.onSuffixIconTapped != null
                ? GestureDetector(
                    onTap: () {
                      widget.onSuffixIconTapped!();
                      // Toggle the visibility when the suffix icon is tapped
                      setState(() {
                        if (widget.onSuffixIconTapped != null) {
                          widget.obscureText = !widget.obscureText;
                        }
                      });
                    },
                    child: Icon(widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintTextt,
            hintStyle: TextStyle(color: Color.fromARGB(255, 141, 141, 141)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
