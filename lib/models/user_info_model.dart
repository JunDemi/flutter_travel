class StoreAuthState {
  final String accessToken;
  final Map<String, dynamic> memberInfo;
  final String refreshToken;

  StoreAuthState({
    required this.accessToken,
    required this.memberInfo,
    required this.refreshToken,
  });

  // JSON에서 StoreAuthState 객체를 생성하는 named 생성자
  factory StoreAuthState.fromJson(Map<String, dynamic> json) {
    return StoreAuthState(
      accessToken: json['accessToken'] ?? '',
      memberInfo: json['memberInfo'] ?? {},
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class UserInfoModel {
  final StoreAuthState storeAuthState;
  //named 생성자
  UserInfoModel.fromJson(Map<String, dynamic> parsedJson)
      : storeAuthState = StoreAuthState.fromJson(parsedJson['state']);
}
