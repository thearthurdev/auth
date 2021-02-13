import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/pages/log_in_password_page.dart';
import 'package:auth/pages/new_password_page.dart';
import 'package:auth/pages/reset_password_page.dart';
import 'package:auth/pages/sign_up_email_page.dart';
import 'package:auth/pages/sign_up_password_page.dart';
import 'package:auth/pages/sign_up_username_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (context) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
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
        home: FutureHomeBuilder(),
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => HomePage(),
          LogInEmailPage.id: (context) => LogInEmailPage(),
          LogInPasswordPage.id: (context) => LogInPasswordPage(),
          SignUpEmailPage.id: (context) => SignUpEmailPage(),
          SignUpPasswordPage.id: (context) => SignUpPasswordPage(),
          SignUpUsernamePage.id: (context) => SignUpUsernamePage(),
          NewPasswordPage.id: (context) => NewPasswordPage(),
          ResetPasswordPage.id: (context) => ResetPasswordPage(),
        },
      ),
    );
  }
}

class FutureHomeBuilder extends StatelessWidget {
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
          return Container(
            color: kPrimaryColor,
            child: Center(
              child: Icon(Icons.error_outline, size: 62.0),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: AuthenticationWrapper(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: kPrimaryColor,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                kPrimaryTextColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return firebaseUser != null ? HomePage() : SignUpUsernamePage();
  }
}
