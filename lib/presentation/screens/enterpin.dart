// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';

import 'package:passguardian/presentation/widgets/custombutton.dart';

import '../../utils/images.dart';
import '../../utils/shared_preferences.dart';
import 'homepage.dart';

class EnterPin extends StatefulWidget {
  const EnterPin({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterPin> createState() => _EnterPinState();
}

class _EnterPinState extends State<EnterPin> {
  final TextEditingController _enterPinController = TextEditingController();

  void _onConfirmPressed() async {
    // get saved (hashed) PIN
    String? savedHashedPin = await SharedPreferencesUtil.getPin();

    if (savedHashedPin != null) {
      // entered PIN
      String enteredPin = _enterPinController.text;

      // Compare the entered PIN and saved (hashed) PIN
      var isCorrect = DBCrypt().checkpw(enteredPin, savedHashedPin);

      if (isCorrect) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect PIN, please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Setup your PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Enter Passcode'),
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
                        'Enter your passcode',
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
                            controller: _enterPinController,
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
