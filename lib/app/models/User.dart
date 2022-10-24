class User {

    String? email;
    int? id;
    String? name;
    String? updated_at;

    User({ this.email, this.id,  this.name , this.updated_at});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(

            email: json['email'], 
            id: json['id'],
            name: json['name'],
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['id'] = this.id;
        data['name'] = this.name;
        data['updated_at'] = this.updated_at;

        return data;
    }
}