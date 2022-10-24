import 'package:brac_arna/app/models/ApiInfo.dart';

class LoginResponse {
    Data? data;
    String? msg;
    String? status;

    LoginResponse({this.data, this.msg, this.status});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        return LoginResponse(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            msg: json['msg'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data!.toJson();
        }
        return data;
    }
}

class Data {
    String? access_token;
    Object? employee_info;
    int? expires_in;
    List<RoleInfo>? role_info;
    String? token_type;
    User? user;

    Data({this.access_token, this.employee_info, this.expires_in, this.role_info, this.token_type, this.user});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            access_token: json['access_token'],
           // employee_info: json['employee_info'] != null ? Object.fromJson(json['employee_info']) : null,
            expires_in: json['expires_in'],
            role_info: json['role_info'] != null ? (json['role_info'] as List).map((i) => RoleInfo.fromJson(i)).toList() : null,
            token_type: json['token_type'],
            user: json['user'] != null ? User.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['access_token'] = this.access_token;
        data['expires_in'] = this.expires_in;
        data['token_type'] = this.token_type;
        // if (this.employee_info != null) {
        //     data['employee_info'] = this.employee_info!.toJson();
        // }
        if (this.role_info != null) {
            data['role_info'] = this.role_info!.map((v) => v.toJson()).toList();
        }
        if (this.user != null) {
            data['user'] = this.user!.toJson();
        }
        return data;
    }
}

class RoleInfo {
    int? role_id;
    String? role_name;

    RoleInfo({this.role_id, this.role_name});

    factory RoleInfo.fromJson(Map<String, dynamic> json) {
        return RoleInfo(
            role_id: json['role_id'],
            role_name: json['role_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['role_id'] = this.role_id;
        data['role_name'] = this.role_name;
        return data;
    }
}

class User {
    String? email;
    int? id;
    String? username;

    User({this.email, this.id, this.username});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            email: json['email'],
            id: json['id'],
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['id'] = this.id;
        data['username'] = this.username;
        return data;
    }
}