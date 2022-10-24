class DispatchSubmitRspopnse {
    String? msg;
    int? next_serial_no;
    String? status;

    DispatchSubmitRspopnse({this.msg, this.next_serial_no, this.status});

    factory DispatchSubmitRspopnse.fromJson(Map<String, dynamic> json) {
        return DispatchSubmitRspopnse(
            msg: json['msg'], 
            next_serial_no: json['next_serial_no'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['next_serial_no'] = this.next_serial_no;
        data['status'] = this.status;
        return data;
    }
}