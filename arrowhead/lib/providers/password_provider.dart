import 'package:arrowhead/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

import '../models/password.dart';

class PasswordProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _imageStorage = FirebaseStorage.instance;

  final String _mainCollection = 'users';
  final String _subCollection = 'passwords';

  String _userId = Auth.INVALID_ID;

  List<Password> _items = [];

  PasswordProvider();
  PasswordProvider.loggedIn(this._userId);

  List<Password> get items => [..._items];
  int get size => _items.length;

  Password findById(String id) =>
      _items.firstWhere((element) => element.id == id);

  Future<void> fetchData() async {
    final data = await _firestore
        .collection(_mainCollection)
        .doc(_userId)
        .collection(_subCollection)
        .get();

    final documents = data.docs;

    if (documents.isEmpty) {
      return;
    }

    _items = documents.map((element) {
      return Password.fromJson(element.data());
    }).toList();

    notifyListeners();
  }

  Future<void> add(Map<String, dynamic>? passwordData) async {
    if (passwordData == null || passwordData.isEmpty) {
      return;
    }

    passwordData[Password.ID_KEY] = _userId + _items.length.toString();
    passwordData[Password.LOGIN_KEY] = '';

    await _firestore
        .collection(_mainCollection)
        .doc(_userId)
        .collection(_subCollection)
        .doc(passwordData[Password.ID_KEY])
        .set(passwordData);

    _items.add(Password.fromJson(passwordData));
    notifyListeners();
  }

  Future<void> remove(String id) async {
    int index = _items.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }

    final removed = _items[index];

    await _firestore
        .collection(_mainCollection)
        .doc(_userId)
        .collection(_subCollection)
        .doc(id)
        .delete();

    _items.remove(removed);
    notifyListeners();
  }

  Future<void> update(Password p) async {
    int index = _items.indexWhere((element) => element.id == p.id);

    if (index == -1) return;

    _items[index] = p;

    await _firestore
        .collection(_mainCollection)
        .doc(_userId)
        .collection(_subCollection)
        .doc(p.id)
        .update(p.toJson);
    notifyListeners();
  }
}
