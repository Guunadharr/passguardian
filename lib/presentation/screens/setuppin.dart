import 'package:flutter/material.dart';
import 'package:passguardian/presentation/screens/confirmpin.dart';
import 'package:passguardian/utils/images.dart';
import 'package:passguardian/presentation/widgets/custombutton.dart';

class SetupPin extends StatefulWidget {
  const SetupPin({super.key});

  @override
  State<SetupPin> createState() => _SetupPinState();
}

class _SetupPinState extends State<SetupPin> {
  final TextEditingController _enterPinController = TextEditingController();

  void _onNextPressed() {
    String passcode = _enterPinController.text;

    if (passcode.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPin(initialPin: passcode),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Setup Passcode'),
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
                      const Text('Create passcode for safety',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
                      CustomButton(onTap: _onNextPressed, buttonText: 'Next')
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
