class UserInfoModel {
  final Map<String, dynamic> memberInfo;
  final String? accessToken;
  final String? refreshToken;
  //named 생성자
  UserInfoModel.fromJson(Map<String, dynamic> parsedJson)
      : memberInfo = parsedJson['memberInfo'],
        accessToken = parsedJson['accessToken'],
        refreshToken = parsedJson['refreshToken'];
        
  Map<String, dynamic> toJson() => {
        'memberInfo': memberInfo,
        'accessToken': accessToken,
        'refreshToken': refreshToken
      };
}

// class MemberInfoModel {
//   final int no;
//   final String role;
//   final String nickanme;
//   final String email;
//   final int status;
//   final bool isOtp;
//   final bool isUnread;
//   final bool isAgent;

//   //named 생성자
//   MemberInfoModel.fromJson(Map<String, dynamic> parsedJson)
//       : no = parsedJson['no'],
//         role = parsedJson['role'],
//         nickanme = parsedJson['nickanme'],
//         email = parsedJson['email'],
//         status = parsedJson['status'],
//         isOtp = parsedJson['isOtp'],
//         isUnread = parsedJson['isUnread'],
//         isAgent = parsedJson['memberInfo'];
// }
