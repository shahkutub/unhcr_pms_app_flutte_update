class Division {
    int? id;
    String? name;

    Division({this.id, this.name});

    factory Division.fromJson(Map<String, dynamic> json) {
        return Division(
            id: json['id'],
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;

        return data;
    }
}