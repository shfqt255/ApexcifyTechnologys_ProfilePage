import 'dart:convert';

import 'package:apexify_tech_profile_manager/edit_profile_screen.dart';
import 'package:apexify_tech_profile_manager/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProfileProvider>(
        builder: (ctx, provider, __) {
          return Column(
            crossAxisAlignment: .center,
            children: [
              CircleAvatar(radius: 60,
               backgroundImage: provider.getImageBase64() ==null ? null: MemoryImage(base64Decode(provider.getImageBase64()!)),
               child: provider.getImageBase64()==null?  Icon(Icons.person, color: Colors.black45, size: 40,) : null,
               
               ),
             ListTile(
              title: Center(child: Text('${provider.getNameController().text}')),
              subtitle: Column(
                crossAxisAlignment: .center,
                children: [
                  Text('${provider.getEmailController().text}'),
                  Text(' Bio: ${provider.getBioController().text}'),
                ],
              ),
            ),   ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
          );
        },
        child: Text('Edit'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
      ),
    );
  }
}
