
class DrugListResponse {
    List<DrugInfo>? drug_info;
    String? msg;
    String? status;

    DrugListResponse({this.drug_info, this.msg, this.status});

    factory DrugListResponse.fromJson(Map<String, dynamic> json) {
        return DrugListResponse(
            drug_info: json['drug_info'] != null ? (json['drug_info'] as List).map((i) => DrugInfo.fromJson(i)).toList() : null,
            msg: json['msg'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.drug_info != null) {
            data['drug_info'] = this.drug_info?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class DrugInfo {
    String? category_id;
    String? category_name;
    String? code_no;
    Object? drug_category;
    Object? generic;
    String? generic_id;
    String? generic_name;
    Object? group;
    String? group_id;
    String? group_name;
    int? id;
    String? manufacturer_id;
    String? name;
    String? pstrength_id;
    int? pstrength_name;
    String? ptype_id;
    String? status;

    DrugInfo({this.category_id, this.category_name, this.code_no, this.drug_category, this.generic, this.generic_id, this.generic_name, this.group, this.group_id, this.group_name, this.id, this.manufacturer_id, this.name, this.pstrength_id,this.pstrength_name, this.ptype_id, this.status});

    factory DrugInfo.fromJson(Map<String, dynamic> json) {
        return DrugInfo(
            category_id: json['category_id'],
            category_name: json['category_name'],
            code_no: json['code_no'],
            //drug_category: json['drug_category'] != null ? Object.fromJson(json['drug_category']) : null,
            //generic: json['generic'] != null ? Object.fromJson(json['generic']) : null,
            generic_id: json['generic_id'],
            generic_name: json['generic_name'],
            //group: json['group'] != null ? Object.fromJson(json['group']) : null,
            group_id: json['group_id'],
            group_name: json['group_name'],
            id: json['id'],
            manufacturer_id: json['manufacturer_id'],
            name: json['name'],
            pstrength_id: json['pstrength_id'],
            ptype_id: json['ptype_id'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['category_name'] = this.category_name;
        data['code_no'] = this.code_no;
        data['generic_id'] = this.generic_id;
        data['generic_name'] = this.generic_name;
        data['group_id'] = this.group_id;
        data['group_name'] = this.group_name;
        data['id'] = this.id;
        data['manufacturer_id'] = this.manufacturer_id;
        data['name'] = this.name;
        data['pstrength_id'] = this.pstrength_id;
        data['ptype_id'] = this.ptype_id;
        data['status'] = this.status;
        // if (this.drug_category != null) {
        //     data['drug_category'] = this.drug_category.toJson();
        // }
        // if (this.generic != null) {
        //     data['generic'] = this.generic.toJson();
        // }
        // if (this.group != null) {
        //     data['group'] = this.group.toJson();
        // }
        return data;
    }
}