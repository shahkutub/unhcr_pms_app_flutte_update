

class StockReceiveMedicineListResponse {
    List<Medicine>? medicine_list;
    String? msg;
    String? status;

    StockReceiveMedicineListResponse({this.medicine_list, this.msg, this.status});

    factory StockReceiveMedicineListResponse.fromJson(Map<String, dynamic> json) {
        return StockReceiveMedicineListResponse(
            medicine_list: json['medicine_list'] != null ? (json['medicine_list'] as List).map((i) => Medicine.fromJson(i)).toList() : null,
            msg: json['msg'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.medicine_list != null) {
            data['medicine_list'] = this.medicine_list!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Medicine {
    String? approved_qty;
    String? category_id;
    String? drug_id;
    String? drug_name;
    String? facility_requested_qty;

    Medicine({this.approved_qty, this.category_id, this.drug_id, this.drug_name, this.facility_requested_qty});

    factory Medicine.fromJson(Map<String, dynamic> json) {
        return Medicine(
            approved_qty: json['approved_qty'],
            category_id: json['category_id'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
            facility_requested_qty: json['facility_requested_qty'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['approved_qty'] = this.approved_qty;
        data['category_id'] = this.category_id;
        data['drug_id'] = this.drug_id;
        data['drug_name'] = this.drug_name;
        data['facility_requested_qty'] = this.facility_requested_qty;
        return data;
    }
}