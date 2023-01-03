

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
    List<StockoutDetail>? stockout_details;
    Medicine({this.approved_qty, this.category_id, this.drug_id, this.drug_name, this.facility_requested_qty, this.stockout_details});

    factory Medicine.fromJson(Map<String, dynamic> json) {
        return Medicine(
            approved_qty: json['approved_qty'],
            category_id: json['category_id'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
            facility_requested_qty: json['facility_requested_qty'],
            stockout_details: json['stockout_details'] != null ? (json['stockout_details'] as List).map((i) => StockoutDetail.fromJson(i)).toList() : null,

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

class StockoutDetail {
    String? approved_supply_qty;
    String? batch_no;
    String? category_id;
    String? drug_id;
    String? drug_name;
    String? expire_date;
    String? facility_stockout_id;
    String? mfg_date;
    String? supplied_qty;
    String? receive_qty;
    String? reject_qty;
    String? reject_reason;
    String? status;

    StockoutDetail({this.approved_supply_qty, this.batch_no, this.category_id,
        this.drug_id, this.drug_name, this.expire_date, this.facility_stockout_id,
        this.mfg_date, this.supplied_qty ,this.receive_qty,this.reject_qty,
        this.reject_reason,this.status});

    factory StockoutDetail.fromJson(Map<String, dynamic> json) {
        return StockoutDetail(
            approved_supply_qty: json['approved_supply_qty'],
            batch_no: json['batch_no'],
            category_id: json['category_id'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
            expire_date: json['expire_date'],
            facility_stockout_id: json['facility_stockout_id'],
            mfg_date: json['mfg_date'],
            supplied_qty: json['supplied_qty'],
            receive_qty: json['receive_qty'],
            reject_qty: json['reject_qty'],
            reject_reason: json['reject_reason'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['approved_supply_qty'] = this.approved_supply_qty;
        data['batch_no'] = this.batch_no;
        data['category_id'] = this.category_id;
        data['drug_id'] = this.drug_id;
        data['drug_name'] = this.drug_name;
        data['expire_date'] = this.expire_date;
        data['facility_stockout_id'] = this.facility_stockout_id;
        data['mfg_date'] = this.mfg_date;
        data['supplied_qty'] = this.supplied_qty;
        data['receive_qty'] = this.receive_qty;
        data['reject_qty'] = this.reject_qty;
        data['reject_reason'] = this.reject_reason;
        return data;
    }
}
