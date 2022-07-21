import 'package:flutter/material.dart';
import 'package:flutter_template/screens/home_screen.dart';
import 'package:flutter_template/utils/authenticate.dart';
import 'package:provider/provider.dart';

import 'models/userModel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel?>(context);
    if (userModel == null) {
      return const Authenticate();
    } else {
      return const HomePage();
    }
  }
}
