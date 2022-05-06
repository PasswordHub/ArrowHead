import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/login.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final collectionName = 'users';

  static const INVALID_ID = '-1';

  Login? _currUser;
  bool _loggedIn = false;

  String get id => _currUser?.id ?? INVALID_ID;
  bool get isLoggedIn => _loggedIn;
  Login? get currUser => _currUser;

  Future<void> signIn(Map<String, String>? userData) async {
    if (userData == null || userData.isEmpty) {
      return;
    }

    final String email = userData[Login.EMAIL_KEY]!;
    final String password = userData[Login.PASSWORD_KEY]!;

    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    String userId = authResult.user?.uid ?? INVALID_ID;

    if (userId == INVALID_ID) {
      return;
    }

    final loginData = await _fetchUserData(userId);
    _currUser = Login.fromJson(loginData.data() as Map<String, dynamic>);
    notifyListeners();
  }

  Future<void> signUp(Map<String, String>? userData) async {
    if (userData == null || userData.isEmpty) {
      return;
    }

    final String email = userData[Login.EMAIL_KEY]!;
    final String password = userData[Login.PASSWORD_KEY]!;

    UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    String userId = authResult.user?.uid ?? INVALID_ID;
    if (userId == INVALID_ID) {
      return;
    }

    userData[Login.ID_KEY] = userId;
    _currUser = Login.fromJson(userData);

    await _firestore.collection(collectionName).doc(userId).set(userData);
    notifyListeners();
  }

  Future<DocumentSnapshot> _fetchUserData(String userId) async =>
      await _firestore.collection(collectionName).doc(userId).get();

  Future<bool> tryAutoLogin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    if (!_loggedIn) {
      final loginData = await _fetchUserData(user.uid);
      if (loginData.data() == null) return false;

      _currUser = Login.fromJson(loginData.data() as Map<String, dynamic>);
      _loggedIn = true;
    }
    notifyListeners();
    return true;
  }

  void logout() {
    _currUser = null;

    _auth.signOut();
    _loggedIn = false;
    notifyListeners();
  }
}
