class PostResponse {
    String? message;
    String? status;

    PostResponse({this.message, this.status});

    factory PostResponse.fromJson(Map<String, dynamic> json) {
        return PostResponse(
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        return data;
    }
}