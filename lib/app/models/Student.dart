class Student {
    String? district_id;
    String? division_id;
    String? education_level_id;
    String? institute_type_id;
    String? management;
    String? thana_id;
    String? total;
    String? total_girls;

    Student({this.district_id, this.division_id, this.education_level_id, this.institute_type_id, this.management, this.thana_id, this.total, this.total_girls});

    factory Student.fromJson(Map<String, dynamic> json) {
        return Student(
            district_id: json['district_id'], 
            division_id: json['division_id'], 
            education_level_id: json['education_level_id'], 
            institute_type_id: json['institute_type_id'], 
            management: json['management'],
            thana_id: json['thana_id'], 
            total: json['total'], 
            total_girls: json['total_girls'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['district_id'] = this.district_id;
        data['division_id'] = this.division_id;
        data['education_level_id'] = this.education_level_id;
        data['institute_type_id'] = this.institute_type_id;
        data['thana_id'] = this.thana_id;
        data['total'] = this.total;
        data['total_girls'] = this.total_girls;
        data['management'] = this.management;

        return data;
    }
}