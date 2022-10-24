import 'package:brac_arna/app/models/Original.dart';

class ApiInfo {
    Original? original;

    ApiInfo({this.original});

    factory ApiInfo.fromJson(Map<String, dynamic> json) {
        return ApiInfo(
            original: json['original'] != null ? Original.fromJson(json['original']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();

        if (this.original != null) {
            data['original'] = this.original?.toJson();
        }
        return data;
    }
}