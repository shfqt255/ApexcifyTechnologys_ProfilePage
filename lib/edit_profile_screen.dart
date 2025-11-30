import 'dart:convert';

import 'package:apexify_tech_profile_manager/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profile.getImageBase64() == null
                        ? null
                        : MemoryImage(base64Decode(profile.getImageBase64()!)),
                    child: profile.getImageBase64() == null
                        ? Icon(Icons.person, size: 40, color: Colors.black45)
                        : null,
                  ),

                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Pick Image'),
                          content: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  profile.pickCameraImage();
                                  Navigator.pop(context);
                                },
                                child: Text("Camera"),
                              ),
                              TextButton(
                                onPressed: () {
                                  profile.pickGalleryImage();
                                  Navigator.pop(context);
                                },
                                child: Text('Gallery'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                _buildTextFormField(profile.getNameController(), 'Name', 1, (
                  value,
                ) {
                  if (value == null || value.isEmpty) {
                    return 'Required field*';
                  } else {
                    return null;
                  }
                }),
                SizedBox(height: 5),
                _buildTextFormField(profile.getEmailController(), 'Email', 1, (
                  value,
                ) {
                  if (value == null || value.isEmpty) {
                    return 'Required field*';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
                }),
                SizedBox(height: 5),
                _buildTextFormField(profile.getBioController(), 'Bio', 3, (
                  value,
                ) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a short Bio';
                  } else {
                    return null;
                  }
                }),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await profile.saveProfile();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),

                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextFormField(
  TextEditingController controller,
  String label,
  int maxlines,
  String? Function(String?) validator,
) {
  return TextFormField(
    controller: controller,
    validator: validator,
    maxLines: maxlines,
    decoration: InputDecoration(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.blueGrey),
      floatingLabelStyle: TextStyle(color: Colors.lightBlue),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue),
      ),
    ),
    cursorColor: Colors.lightBlue,
    cursorErrorColor: Colors.lightBlue,
  );
}
