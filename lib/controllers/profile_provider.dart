import 'package:flutter/material.dart';
import 'package:jobhubv2_0/models/response/auth/profile_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  // Future<ProfileRes>? profile;
  Future<ProfileRes> getProfile() async {
    var profile = AuthHelper.getProfile();

    return profile;
  }
}
