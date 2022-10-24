class LoginDataResponse {
    Data? data;
    String? msg;
    String? status;

    LoginDataResponse({this.data, this.msg, this.status});

    factory LoginDataResponse.fromJson(Map<String, dynamic> json) {
        return LoginDataResponse(
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
    int? expires_in;
    List<Menu>? menus;
    List<Role>? roles;
    String? token_type;
    Users? users;

    Data({this.access_token, this.expires_in, this.menus, this.roles, this.token_type, this.users});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            access_token: json['access_token'],
            expires_in: json['expires_in'],
            menus: json['menus'] != null ? (json['menus'] as List).map((i) => Menu.fromJson(i)).toList() : null,
            roles: json['roles'] != null ? (json['roles'] as List).map((i) => Role.fromJson(i)).toList() : null,
            token_type: json['token_type'],
            users: json['users'] != null ? Users.fromJson(json['users']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['access_token'] = this.access_token;
        data['expires_in'] = this.expires_in;
        data['token_type'] = this.token_type;
        if (this.menus != null) {
            data['menus'] = this.menus!.map((v) => v.toJson()).toList();
        }
        if (this.roles != null) {
            data['roles'] = this.roles!.map((v) => v.toJson()).toList();
        }
        if (this.users != null) {
            data['users'] = this.users!.toJson();
        }
        return data;
    }
}

class Users {
    String? email;
    int? id;
    String? username;

    Users({this.email, this.id, this.username});

    factory Users.fromJson(Map<String, dynamic> json) {
        return Users(
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

class Menu {
    List<Children>? children;
    Object? icon;
    String? name;
    String? path;

    Menu({this.children, this.icon, this.name, this.path});

    factory Menu.fromJson(Map<String, dynamic> json) {
        return Menu(
            children: json['children'] != null ? (json['children'] as List).map((i) => Children.fromJson(i)).toList() : null,
            //icon: json['icon'] != null ? Object.fromJson(json['icon']) : null,
            name: json['name'],
            path: json['path'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['path'] = this.path;
        if (this.children != null) {
            data['children'] = this.children!.map((v) => v.toJson()).toList();
        }
        // if (this.icon != null) {
        //     data['icon'] = this.icon.toJson();
        // }
        return data;
    }
}

class Children {
    Object? icon;
    String? name;
    String? path;

    Children({this.icon, this.name, this.path});

    factory Children.fromJson(Map<String, dynamic> json) {
        return Children(
            //icon: json['icon'] != null ? Object.fromJson(json['icon']) : null,
            name: json['name'],
            path: json['path'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['path'] = this.path;
        // if (this.icon != null) {
        //     data['icon'] = this.icon.toJson();
        // }
        return data;
    }
}

class Role {
    String? role_id;
    String? role_name;

    Role({this.role_id, this.role_name});

    factory Role.fromJson(Map<String, dynamic> json) {
        return Role(
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