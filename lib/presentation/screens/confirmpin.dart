// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:passguardian/presentation/widgets/custombutton.dart';

import '../../utils/images.dart';
import '../../utils/shared_preferences.dart';
import 'homepage.dart';

class ConfirmPin extends StatefulWidget {
  final String initialPin;
  const ConfirmPin({
    Key? key,
    required this.initialPin,
  }) : super(key: key);

  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> {
  final TextEditingController _confirmPinController = TextEditingController();

  void _onConfirmPressed() async {
    String confirmPin = _confirmPinController.text;

    if (confirmPin == widget.initialPin) {
      String hashedPin = SharedPreferencesUtil.hashPin(widget.initialPin);
      SharedPreferencesUtil.savePin(hashedPin);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN, please try again.')),
      );

      // Clear the entered PIN for retry
      _confirmPinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Confirm Passcode'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image
                Image.asset(pin_image, height: 400),
                const SizedBox(height: 20),
                // Column consists of Text, Textfield, Elevated button
                Container(
                  height: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Create PIN for Safety
                      const Text(
                        'Confirm your passcode',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      // Passcode Textfield
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          color: const Color.fromARGB(255, 218, 238, 255),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            controller: _confirmPinController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your passcode',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: SizedBox(),
                      ),

                      // Elevated button
                      CustomButton(
                          onTap: _onConfirmPressed, buttonText: 'Confirm')
                    ],
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
