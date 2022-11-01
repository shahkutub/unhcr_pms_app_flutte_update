
class LoginResponseDept {
    Data? data;
    String? message;
    String? status;

    LoginResponseDept({this.data, this.message, this.status});

    factory LoginResponseDept.fromJson(Map<String, dynamic> json) {
        return LoginResponseDept(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            message: json['message'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data!.toJson();
        }
        return data;
    }
}

class Data {
    String? access_token;
    EmployeeInfo? employee_info;
    int? expires_in;
    List<Menu>? menus;
    List<Role>? roles;
    String? token_type;
    Users? users;

    Data({this.access_token, this.employee_info, this.expires_in, this.menus, this.roles, this.token_type, this.users});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            access_token: json['access_token'],
            employee_info: json['employee_info'] != null ? EmployeeInfo.fromJson(json['employee_info']) : null,
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
        if (this.employee_info != null) {
            data['employee_info'] = this.employee_info!.toJson();
        }
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
    String? name;
    String? path;

    Menu({this.children, this.name, this.path});

    factory Menu.fromJson(Map<String, dynamic> json) {
        return Menu(
            children: json['children'] != null ? (json['children'] as List).map((i) => Children.fromJson(i)).toList() : null,
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

        return data;
    }
}

class Children {
    String? name;
    String? path;

    Children({this.name, this.path});

    factory Children.fromJson(Map<String, dynamic> json) {
        return Children(
            name: json['name'],
            path: json['path'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['path'] = this.path;

        return data;
    }
}





class EmployeeInfo {
    String? code_no;
    String? designation;
    String? dispensary_id;
    String? dispensary_name;
    String? facility_id;
    String? facility_name;
    String? first_name;
    String? last_name;
    String? layer_id;
    String? nid_no;
    String? partner_id;
    String? partner_name;

    EmployeeInfo({this.code_no, this.designation, this.dispensary_id, this.dispensary_name, this.facility_id, this.facility_name, this.first_name, this.last_name, this.layer_id, this.nid_no, this.partner_id, this.partner_name});

    factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
        return EmployeeInfo(
            code_no: json['code_no'],
            designation: json['designation'],
            dispensary_id: json['dispensary_id'],
            dispensary_name: json['dispensary_name'],
            facility_id: json['facility_id'],
            facility_name: json['facility_name'],
            first_name: json['first_name'],
            last_name: json['last_name'],
            layer_id: json['layer_id'],
            nid_no: json['nid_no'],
            partner_id: json['partner_id'],
            partner_name: json['partner_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code_no'] = this.code_no;
        data['designation'] = this.designation;
        data['dispensary_id'] = this.dispensary_id;
        data['dispensary_name'] = this.dispensary_name;
        data['facility_id'] = this.facility_id;
        data['facility_name'] = this.facility_name;
        data['first_name'] = this.first_name;
        data['last_name'] = this.last_name;
        data['layer_id'] = this.layer_id;
        data['nid_no'] = this.nid_no;
        data['partner_id'] = this.partner_id;
        data['partner_name'] = this.partner_name;
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