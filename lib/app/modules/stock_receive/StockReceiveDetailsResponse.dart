
class StockReceiveDetailsResponse {
    List<Medicine>? medicine_list;
    String? msg;
    String? status;

    StockReceiveDetailsResponse({this.medicine_list, this.msg, this.status});

    factory StockReceiveDetailsResponse.fromJson(Map<String, dynamic> json) {
        return StockReceiveDetailsResponse(
            medicine_list: json['medicine_list'] != null ? (json['medicine_list'] as List).map((i) => Medicine.fromJson(i)).toList() : null,
            msg: json['msg'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;

        return data;
    }
}

class Medicine {
    String? approved_supply_qty;
    String? available_stock;
    String? batch_no;
    String? category_id;
    String? dispensary_name;
    String? drug_id;
    String? drug_name;
    String? expire_date;
    String? mfg_date;
    String? received_qty;
    String? rejected_qty;
    String? supplied_qty;

    Medicine({this.approved_supply_qty, this.available_stock, this.batch_no, this.category_id, this.dispensary_name, this.drug_id, this.drug_name, this.expire_date, this.mfg_date, this.received_qty, this.rejected_qty,  this.supplied_qty});

    factory Medicine.fromJson(Map<String, dynamic> json) {
        return Medicine(
            approved_supply_qty: json['approved_supply_qty'],
            available_stock: json['available_stock'],
            batch_no: json['batch_no'],
            category_id: json['category_id'],
            dispensary_name: json['dispensary_name'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
            expire_date: json['expire_date'],
            mfg_date: json['mfg_date'],
            received_qty: json['received_qty'],
            rejected_qty: json['rejected_qty'],
            supplied_qty: json['supplied_qty'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['approved_supply_qty'] = this.approved_supply_qty;
        data['available_stock'] = this.available_stock;
        data['batch_no'] = this.batch_no;
        data['category_id'] = this.category_id;
        data['dispensary_name'] = this.dispensary_name;
        data['drug_id'] = this.drug_id;
        data['drug_name'] = this.drug_name;
        data['expire_date'] = this.expire_date;
        data['mfg_date'] = this.mfg_date;
        data['received_qty'] = this.received_qty;
        data['rejected_qty'] = this.rejected_qty;
        data['supplied_qty'] = this.supplied_qty;

        return data;
    }
}