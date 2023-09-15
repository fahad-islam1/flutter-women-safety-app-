// for authentication
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

FirebaseAuth auth = FirebaseAuth.instance;
// for storing
FirebaseFirestore firestore = FirebaseFirestore.instance;

// this is current user
var usercollection = 'users';
var chatcollection = 'chat';
var reviewcollection = 'review';
var msgcollection = 'message';
var allmsgcollection = 'allmessage';

User? currentUser = auth.currentUser;
// creating user detail in firebase
var currentId = currentUser!.uid;
var logger = Logger();
