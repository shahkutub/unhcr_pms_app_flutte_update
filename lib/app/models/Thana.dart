class Thana {
    int? district_id;
    int? division_id;
    int? id;
    String? name;

    Thana({this.district_id, this.division_id, this.id, this.name});

    factory Thana.fromJson(Map<String, dynamic> json) {
        return Thana(
            district_id: json['district_id'],
            division_id: json['division_id'], 
            id: json['id'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['district_id'] = this.district_id;
        data['division_id'] = this.division_id;
        data['id'] = this.id;
        data['name'] = this.name;

        return data;
    }
}