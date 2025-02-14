import 'dart:convert';

import 'package:flutter_travel/models/user_info_model.dart';

class DecodeJson {
  static Future<UserInfoModel> getParseUserInfo(String userInfo) async {
      final parseUserInfo = jsonDecode(userInfo);
      return UserInfoModel.fromJson(parseUserInfo);
  }
}