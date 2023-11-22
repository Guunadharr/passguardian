// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSuffixIconTapped;
  bool obscureText;
  String hintTextt;

  CustomTextField({
    Key? key,
    required this.controller,
    this.onSuffixIconTapped,
    required this.hintTextt,
    this.obscureText = true,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 70,
        width: double.infinity,
        color: Color.fromARGB(255, 218, 238, 255),
        child: Center(
          child: TextField(
            obscureText: widget.obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
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
      ),
    );
  }
}
