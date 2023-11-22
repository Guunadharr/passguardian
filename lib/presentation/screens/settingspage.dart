import 'package:flutter/material.dart';
import 'package:passguardian/presentation/screens/homepage.dart';

import '../../domain/repositories/biometric_repository.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final BiometricAuthentication biometricAuth = BiometricAuthentication();

  @override
  void initState() {
    super.initState();
    biometricAuth.checkFingerprintOnAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Security',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.password, size: 40),
                  title: Text('Change password'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  biometricAuth.checkFingerprintOnAppOpen();
                },
                child: ListTile(
                  leading: Icon(Icons.fingerprint, size: 40),
                  title: Text('Fingerprint'),
                  subtitle: Text(biometricAuth.isFingerprintEnabled
                      ? 'Disable'
                      : 'Enable'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Help',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.feedback, size: 40),
                  title: Text('Send feedback'),
                  subtitle:
                      Text('Report technical issues or suggest new features'),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.share, size: 40),
                  title: Text('Share'),
                  subtitle: Text('Share app with others'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
