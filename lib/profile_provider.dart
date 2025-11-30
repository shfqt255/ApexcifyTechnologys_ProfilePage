import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    loadProfile();
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _imageBase64;

  Future<void> pickCameraImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      _imageBase64 = base64Encode(bytes);
    }
  }
    Future<void> pickGalleryImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      _imageBase64 = base64Encode(bytes);
    }
  }

  TextEditingController getNameController() => _nameController;
  TextEditingController getEmailController() => _emailController;
  TextEditingController getBioController() => _bioController;
  String? getImageBase64() => _imageBase64;

  Future<void> saveProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', _nameController.text);
    sharedPreferences.setString('email', _emailController.text);
    sharedPreferences.setString('bio', _bioController.text);
    sharedPreferences.setString('Profile_Image', _imageBase64 ?? '');
    notifyListeners();
  }

  Future<void> loadProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _nameController.text = sharedPreferences.getString('name') ?? '';
    _emailController.text = sharedPreferences.getString('email') ?? '';
    _bioController.text = sharedPreferences.getString('bio') ?? '';
    _imageBase64 = sharedPreferences.getString('Profile_image') ?? '';
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
