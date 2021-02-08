import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/sign_up_username_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Auth());
}

class Auth extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(home: Text('oops'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: MultiProvider(
              providers: [
                Provider<AuthenticationService>(
                  create: (_) => AuthenticationService(FirebaseAuth.instance),
                ),
                StreamProvider(
                  create: (context) =>
                      context.read<AuthenticationService>().authStateChanges,
                ),
                ChangeNotifierProvider<AuthenticationProvider>(
                  create: (context) => AuthenticationProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Auth',
                theme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: kPrimaryColor,
                  accentColor: kAccentColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: AuthenticationWrapper(),
                debugShowCheckedModeBanner: false,
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: Text('loading...'));
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }

    return SignUpUsernamePage();
  }
}
