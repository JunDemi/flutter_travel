import 'dart:convert';

import 'package:flutter_travel/models/user_info_model.dart';

class DecodeJson {
  static UserInfoModel getParseUserState(String userInfo) {
    //JSON 파싱
    final parseUserInfo = jsonDecode(userInfo);

    //storeAuthState 데이터 접근
    var getUserInfo =
        UserInfoModel.fromJson(parseUserInfo['state']['storeAuthState']);

    return getUserInfo;
  }
}
