class CurrentStockRequestModel {
    List<int>? dispensary_ids;
    List<int>? facility_ids;
    String? layer;
    List<int>? partner_ids;

    CurrentStockRequestModel({this.dispensary_ids, this.facility_ids, this.layer, this.partner_ids});

    factory CurrentStockRequestModel.fromJson(Map<String, dynamic> json) {
        return CurrentStockRequestModel(
            dispensary_ids: json['dispensary_ids'] != null ? new List<int>.from(json['dispensary_ids']) : null,
            facility_ids: json['facility_ids'] != null ? new List<int>.from(json['facility_ids']) : null,
            layer: json['layer'],
            partner_ids: json['partner_ids'] != null ? new List<int>.from(json['partner_ids']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['layer'] = this.layer;
        if (this.dispensary_ids != null) {
            data['dispensary_ids'] = this.dispensary_ids;
        }
        if (this.facility_ids != null) {
            data['facility_ids'] = this.facility_ids;
        }
        if (this.partner_ids != null) {
            data['partner_ids'] = this.partner_ids;
        }
        return data;
    }
}