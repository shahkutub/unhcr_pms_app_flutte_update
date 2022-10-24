class UserModel {
  bool? isLoggedIn;
  int? userId;
  String? fullName;
  String? userName;
  String? password;
  int? roleId;
  String? roleName;
  String? message;
  String? token;

  UserModel({this.isLoggedIn, this.userId, this.fullName, this.userName, this.password, this.roleId, this.roleName, this.message, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    isLoggedIn = json['IsLoggedIn'];
    userId = json['UserId'];
    fullName = json['FullName'];
    userName = json['UserName'];
    roleId = json['RoleId'];
    roleName = json['RoleName'];
    message = json['Message'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsLoggedIn'] = this.isLoggedIn;
    data['UserId'] = this.userId;
    data['FullName'] = this.fullName;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['RoleId'] = this.roleId;
    data['RoleName'] = this.roleName;
    data['Message'] = this.message;
    data['Token'] = this.token;
    return data;
  }
}