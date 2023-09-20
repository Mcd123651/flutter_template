import 'package:flutter/material.dart';
import 'package:flutter_template/screens/login/login_screen.dart';
import 'package:flutter_template/utils/db.dart';
import 'package:flutter_template/utils/router.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';

// identify if authenticated.
// if not auth: go to sign in screen
// if auth: stream the AppUser ( Wrapper 2 )
class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final _dbService = DatabaseService(); // Single instance

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser?>(context);
    if (authUser == null) {
      return const LoginScreen();
    } else {
      _dbService.createUser(authUser); // Reuse instance
      return StreamProvider<AppUser?>.value(
        initialData: null,
        value: _dbService.streamAppUser(authUser), // Reuse instance
        child: const Wrapper2(),
      );
    }
  }
}

// circular progress bar while waiting for AppUser to start streaming
// once complete -> navigate to routes page.
class Wrapper2 extends StatelessWidget {
  const Wrapper2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);
    if (appUser == null) {
      return const CircularProgressIndicator(
        semanticsLabel: 'Linear progress indicator',
      );
    } else {
      return const MainScreen();
    }
  }
}
