
class CurrentStockMedicineListResponse {
    List<CurrentStockInfo>? current_stock_info;
    String? layer;
    String? message;
    String? status;

    CurrentStockMedicineListResponse({this.current_stock_info, this.layer, this.message, this.status});

    factory CurrentStockMedicineListResponse.fromJson(Map<String, dynamic> json) {
        return CurrentStockMedicineListResponse(
            current_stock_info: json['current_stock_info'] != null ? (json['current_stock_info'] as List).map((i) => CurrentStockInfo.fromJson(i)).toList() : null,
            layer: json['layer'],
            message: json['message'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['layer'] = this.layer;
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.current_stock_info != null) {
            data['current_stock_info'] = this.current_stock_info?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class CurrentStockInfo {
    List<BatchInfo>? batch_info;
    String? category_id;
    String? category_name;
    String? code_no;
    String? dispensary_name;
    String? drug_id;
    String? drug_name;

    CurrentStockInfo({this.batch_info, this.category_id, this.category_name, this.code_no, this.dispensary_name, this.drug_id, this.drug_name});

    factory CurrentStockInfo.fromJson(Map<String, dynamic> json) {
        return CurrentStockInfo(
            batch_info: json['batch_info'] != null ? (json['batch_info'] as List).map((i) => BatchInfo.fromJson(i)).toList() : null,
            category_id: json['category_id'],
            category_name: json['category_name'],
            code_no: json['code_no'],
            dispensary_name: json['dispensary_name'],
            drug_id: json['drug_id'],
            drug_name: json['drug_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['category_name'] = this.category_name;
        data['code_no'] = this.code_no;
        data['dispensary_name'] = this.dispensary_name;
        data['drug_id'] = this.drug_id;
        data['drug_name'] = this.drug_name;
        if (this.batch_info != null) {
            data['batch_info'] = this.batch_info?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class BatchInfo {
    String? available_qty;
    String? batch_no;
    String? expire_date;
    String? mfg_date;

    BatchInfo({this.available_qty, this.batch_no, this.expire_date, this.mfg_date});

    factory BatchInfo.fromJson(Map<String, dynamic> json) {
        return BatchInfo(
            available_qty: json['available_qty'],
            batch_no: json['batch_no'],
            expire_date: json['expire_date'],
            mfg_date: json['mfg_date'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['available_qty'] = this.available_qty;
        data['batch_no'] = this.batch_no;
        data['expire_date'] = this.expire_date;
        data['mfg_date'] = this.mfg_date;
        return data;
    }
}