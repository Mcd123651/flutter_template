import 'package:flutter/material.dart';
import 'package:flutter_template/screens/sign_in_screen.dart';
import 'package:flutter_template/utils/db.dart';
import 'package:flutter_template/utils/router.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';

// identify if authenticated.
// if not auth: go to sign in screen
// if auth: stream the AppUser ( Wrapper 2 )
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser?>(context);
    if (authUser == null) {
      return SignInScreen();
    } else {
      DatabaseService().createUser(authUser);
      return StreamProvider<AppUser?>.value(
        initialData: null,
        value: DatabaseService().streamAppUser(authUser),
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
