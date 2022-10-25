
class MedicineListResponse {
    List<DispatchItem>? dispatch_items;
    String? msg;
    int? status;

    MedicineListResponse({this.dispatch_items, this.msg, this.status});

    factory MedicineListResponse.fromJson(Map<String, dynamic> json) {
        return MedicineListResponse(
            dispatch_items: json['dispatch_items'] != null ? (json['dispatch_items'] as List).map((i) => DispatchItem.fromJson(i)).toList() : null,
            msg: json['msg'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.dispatch_items != null) {
            data['dispatch_items'] = this.dispatch_items!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class DispatchItem {
    String? available_stock;
    String? receive_stock;
    String? dispatch_stock;
    String? lose_stock;
    String? batch_no;
    String? category_id;
    String? category_name;
    String? code_no;
    String? dispensary_id;
    String? dispensary_name;
    String? drug_id;
    String? drug_name;
    String? facility_id;
    String? facility_name;
    String? generic_id;
    String? generic_name;
    String? group_id;
    String? group_name;
    String? partner_id;
    String? partner_name;
    String? pstrength_id;
    String? ptype;
    String? ptype_id;
    String? strength_name;
    String? therapeutic_name;

    DispatchItem({this.available_stock,this.receive_stock,this.dispatch_stock,this.lose_stock, this.batch_no, this.category_id, this.category_name, this.code_no, this.dispensary_id, this.dispensary_name, this.drug_id, this.drug_name, this.facility_id, this.facility_name, this.generic_id, this.generic_name, this.group_id, this.group_name, this.partner_id, this.partner_name, this.pstrength_id, this.ptype, this.ptype_id, this.strength_name, this.therapeutic_name});

    factory DispatchItem.fromJson(Map<String, dynamic> json) {
        return DispatchItem(
            available_stock: json['available_stock'],
            batch_no: json['batch_no'],
            category_id: json['category_id'],
            category_name: json['category_name'],
            code_no: json['code_no'],
            dispensary_id: json['dispensary_id'],
            dispensary_name: json['dispensary_name'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
            facility_id: json['facility_id'],
            facility_name: json['facility_name'],
            generic_id: json['generic_id'],
            generic_name: json['generic_name'],
            group_id: json['group_id'],
            group_name: json['group_name'],
            partner_id: json['partner_id'],
            partner_name: json['partner_name'],
            pstrength_id: json['pstrength_id'],
            ptype: json['ptype'],
            ptype_id: json['ptype_id'],
            strength_name: json['strength_name'],
            //therapeutic_name: json['therapeutic_name'] != null ? String?.fromJson(json['therapeutic_name']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['available_stock'] = this.available_stock;
        data['batch_no'] = this.batch_no;
        data['category_id'] = this.category_id;
        data['category_name'] = this.category_name;
        data['code_no'] = this.code_no;
        data['dispensary_id'] = this.dispensary_id;
        data['dispensary_name'] = this.dispensary_name;
        data['drug_id'] = this.drug_id;
        data['drug_name'] = this.drug_name;
        data['facility_id'] = this.facility_id;
        data['facility_name'] = this.facility_name;
        data['generic_id'] = this.generic_id;
        data['generic_name'] = this.generic_name;
        data['group_id'] = this.group_id;
        data['group_name'] = this.group_name;
        data['partner_id'] = this.partner_id;
        data['partner_name'] = this.partner_name;
        data['pstrength_id'] = this.pstrength_id;
        data['ptype'] = this.ptype;
        data['ptype_id'] = this.ptype_id;
        data['strength_name'] = this.strength_name;
        // if (this.therapeutic_name != null) {
        //     data['therapeutic_name'] = this.therapeutic_name.toJson();
        // }
        return data;
    }
}