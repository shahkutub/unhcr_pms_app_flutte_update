class PoridorshonDataModel {
    String? location;
    String? date;
    String? nameInstitute;
    String? namePoridorshok;



  PoridorshonDataModel({this.location, this.date, this.nameInstitute, this.namePoridorshok});

    factory PoridorshonDataModel.fromJson(Map<String, dynamic> json) {
        return PoridorshonDataModel(
            location: json['location'],
            date: json['date'],
            nameInstitute: json['nameInstitute'],
            namePoridorshok: json['namePoridorshok'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['location'] = this.location;
        data['date'] = this.date;
        data['nameInstitute'] = this.nameInstitute;
        data['namePoridorshok'] = this.namePoridorshok;

        return data;
    }
}