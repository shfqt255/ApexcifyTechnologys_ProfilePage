import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    loadProfile();
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  TextEditingController getNameController() => _nameController;
  TextEditingController getEmailController() => _emailController;
  TextEditingController getBioController() => _bioController;

  Future<void> saveProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', _nameController.text);
    sharedPreferences.setString('email', _emailController.text);
    sharedPreferences.setString('bio', _bioController.text);
    notifyListeners();
  }

  Future<void> loadProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _nameController.text = sharedPreferences.getString('name') ?? '';
    _emailController.text = sharedPreferences.getString('email') ?? '';
    _bioController.text = sharedPreferences.getString('bio') ?? '';
    notifyListeners();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
