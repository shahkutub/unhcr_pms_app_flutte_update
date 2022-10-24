import 'package:brac_arna/app/models/User.dart';

class Original {
    String? access_token;
    int? expires_in;
    String? token_type;
    User? user;

    Original({this.access_token, this.expires_in, this.token_type, this.user});

    factory Original.fromJson(Map<String, dynamic> json) {
        return Original(
            access_token: json['access_token'], 
            expires_in: json['expires_in'], 
            token_type: json['token_type'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['access_token'] = this.access_token;
        data['expires_in'] = this.expires_in;
        data['token_type'] = this.token_type;
        if (this.user != null) {
            data['user'] = this.user?.toJson();
        }
        return data;
    }
}