

class StockReceiveResponse {
  List<Distribution>? distribution_list;
  String? msg;
  String? status;

  StockReceiveResponse({this.distribution_list, this.msg, this.status});

  factory StockReceiveResponse.fromJson(Map<String, dynamic> json) {
    return StockReceiveResponse(
      distribution_list: json['distribution_list'] != null ? (json['distribution_list'] as List).map((i) => Distribution.fromJson(i)).toList() : null,
      msg: json['msg'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.distribution_list != null) {
      data['distribution_list'] = this.distribution_list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Distribution {
  String? dispensary_id;
  String? dispensary_name;
  String? distribution_type;
  String? facility_id;
  int? id;
  String? received_by;
  String? received_date;
  String? status;
  String? stockout_date;
  String? supplied_by;
  String? supply_approval_date;
  String? supply_approved_by;
  String? supply_date;

  Distribution({this.dispensary_id, this.dispensary_name, this.distribution_type, this.facility_id, this.id, this.received_by, this.received_date, this.status, this.stockout_date, this.supplied_by, this.supply_approval_date, this.supply_approved_by, this.supply_date});

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      dispensary_id: json['dispensary_id'],
      dispensary_name: json['dispensary_name'],
      distribution_type: json['distribution_type'],
      facility_id: json['facility_id'],
      id: json['id'],
      received_by: json['received_by'],
      received_date: json['received_date'],
      status: json['status'],
      stockout_date: json['stockout_date'],
      supplied_by: json['supplied_by'],
      supply_approval_date: json['supply_approval_date'],
      supply_approved_by: json['supply_approved_by'],
      supply_date: json['supply_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dispensary_id'] = this.dispensary_id;
    data['dispensary_name'] = this.dispensary_name;
    data['distribution_type'] = this.distribution_type;
    data['facility_id'] = this.facility_id;
    data['id'] = this.id;
    data['received_by'] = this.received_by;
    data['received_date'] = this.received_date;
    data['status'] = this.status;
    data['stockout_date'] = this.stockout_date;
    data['supplied_by'] = this.supplied_by;
    data['supply_approval_date'] = this.supply_approval_date;
    data['supply_approved_by'] = this.supply_approved_by;
    data['supply_date'] = this.supply_date;
    return data;
  }
}