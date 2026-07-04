class User {
  final String userId;
  final String username;
  final String nickname;
  final String avatar;
  final String email;
  final String phone;
  final String deptName;

  User({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.deptName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      deptName: json['deptName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'nickname': nickname,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'deptName': deptName,
    };
  }
}
