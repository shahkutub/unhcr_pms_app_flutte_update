class District {
    int? division_id;
    int? id;
    String? name;

    District({ this.division_id, this.id, this.name});

    factory District.fromJson(Map<String, dynamic> json) {
        return District(
            division_id: json['division_id'],
            id: json['id'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['division_id'] = this.division_id;
        data['id'] = this.id;
        data['name'] = this.name;

        return data;
    }
}