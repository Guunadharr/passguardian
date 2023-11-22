// biometric_authentication.dart

import 'package:local_auth/local_auth.dart';

class BiometricAuthentication {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool isFingerprintEnabled = false;

  Future<void> checkFingerprintOnAppOpen() async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        await authenticateWithFingerprint();
      }
    }
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      bool authenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to enable fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        isFingerprintEnabled = true;
        print('Fingerprint authentication successful');
      } else {
        print('Fingerprint authentication failed');
      }
    } catch (e) {
      print('Error during fingerprint authentication: $e');
    }
  }
}
