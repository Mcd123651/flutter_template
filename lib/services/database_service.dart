// ignore_for_file: non_constant_identifier_names, library_prefixes
library database_service;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/models/userModel.dart';
part 'database_service/user_functions.dart';

class DatabaseService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
}
