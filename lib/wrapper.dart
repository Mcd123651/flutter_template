import 'package:flutter/material.dart';
import 'package:flutter_template/screens/sign_in_screen.dart';
import 'package:flutter_template/utils/db.dart';
import 'package:flutter_template/utils/router.dart';
import 'package:provider/provider.dart';

import 'models/userModel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser?>(context);
    if (authUser == null) {
      return SignInScreen();
    } else {
      DatabaseService().createUser(authUser);
      return const MainScreen();
    }
  }
}
