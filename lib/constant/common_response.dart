class CommonResponse {
  bool? status;
  int? intimeId;
  String? message;

  CommonResponse({this.status, this.intimeId, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    intimeId = json['intime_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['intime_id'] = intimeId;
    data['message'] = message;
    return data;
  }
}