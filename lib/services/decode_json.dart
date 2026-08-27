import 'dart:convert';

import 'package:otc_mobile/models/user_info_model.dart';

const String defaultInfo =
    '{"accessToken": "", "memberInfo": {"isLogin": false}, "refreshToken": ""}';

class DecodeJson {
  static UserInfoModel getParseUserState(String infoState) {
    final userInfo = infoState == '' ? defaultInfo : infoState;
    //JSON 파싱
    final parseUserInfo = jsonDecode(userInfo);
    var getUserInfo = UserInfoModel.fromJson(parseUserInfo);
    return getUserInfo;
  }
}
