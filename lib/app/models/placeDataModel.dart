class PlaceDataModel {
  List<Area>? area;

  PlaceDataModel({this.area});

  PlaceDataModel.fromJson(Map<String, dynamic> json) {
    if (json['Area'] != null) {
      area = <Area>[];
      json['Area'].forEach((v) {
        area!.add(new Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.area != null) {
      data['Area'] = this.area!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Area {
  String? divisionId;
  String? divisionName;
  String? districtId;
  String? districtName;
  String? upazilaId;
  String? upazilaName;
  String? unionId;
  String? unionName;

  Area({this.divisionId, this.divisionName, this.districtId, this.districtName, this.upazilaId, this.upazilaName, this.unionId, this.unionName});

  Area.fromJson(Map<String, dynamic> json) {
    divisionId = json['division_id'].toString();
    divisionName = json['division_name'];
    districtId = json['district_id'].toString();
    districtName = json['district_name'];
    upazilaId = json['upazila_id'].toString();
    upazilaName = json['upazila_name'];
    unionId = json['union_id'].toString();
    unionName = json['union_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['division_id'] = this.divisionId;
    data['division_name'] = this.divisionName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['union_id'] = this.unionId;
    data['union_name'] = this.unionName;
    return data;
  }
}
