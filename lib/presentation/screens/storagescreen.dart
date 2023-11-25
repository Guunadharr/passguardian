// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:passguardian/presentation/widgets/custombutton.dart';
import 'package:passguardian/presentation/widgets/customtextfield.dart';

import '../../storageservice.dart';

class StorageScreen extends StatefulWidget {
  final String? accountName;
  final String? email;
  final String? password;
  final String? notes;
  const StorageScreen({
    Key? key,
    this.accountName,
    this.email,
    this.password,
    this.notes,
  }) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  // text controllers
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _additionalPasswordController = TextEditingController();

  String _selectedCategory = 'Mail'; //Default Category

  Future<void> _loadDataFromLocal() async {
    Map<String, String> data = await StorageService.loadDataFromLocal();
    setState(() {
      _accountNameController.text = data['accountName'] ?? '';
      _emailController.text = data['email'] ?? '';
      _passwordController.text = data['password'] ?? '';
      _notesController.text = data['notes'] ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountNameController.text = widget.accountName ?? '';
    _emailController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
    _notesController.text = widget.notes ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: ['Mail', 'Bank Account']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      // Account name
                      CustomTextField(
                          obscureText: false,
                          controller: _accountNameController,
                          hintTextt: 'Account name'),
                      SizedBox(height: 20),
                      // Email textfield
                      CustomTextField(
                        obscureText: false,
                        controller: _emailController,
                        hintTextt: 'Username/Email/Mobile',
                      ),
                      SizedBox(height: 20),
                      // Password textfield
                      CustomTextField(
                        showReplayButton: true,
                        onSuffixIconTapped: () {},
                        controller: _passwordController,
                        hintTextt: 'Password',
                      ),
                      SizedBox(height: 20),
                      if (_selectedCategory ==
                          'Bank Account') // Show additional password field for Bank Account

                        CustomTextField(
                          controller: _additionalPasswordController,
                          hintTextt: 'Additional Password',
                        ),
                      SizedBox(height: 20),
                      // Notes TextField
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 100,
                          width: double.infinity,
                          color: Color.fromARGB(255, 218, 238, 255),
                          child: TextField(
                            controller: _notesController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: 'Notes(optional)',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.lightBlue[50],
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  onTap: () async {
                    String accountName = _accountNameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String notes = _notesController.text;

                    // Save data to local storage
                    await StorageService.saveDataToLocal(
                      accountName: accountName,
                      email: email,
                      password: password,
                      notes: notes,
                    );

                    // Pass the data back to HomePage
                    Navigator.pop(context, {
                      'accountName': accountName,
                      'email': email,
                      'password': password,
                      'notes': notes
                    });
                  },
                  buttonText: 'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
