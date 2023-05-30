class ClientDashboardModel {
  String? message;
  bool? success;
  List<ClientDashboardList>? clientDashboardList;

  ClientDashboardModel({this.message, this.success, this.clientDashboardList});

  ClientDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      clientDashboardList = <ClientDashboardList>[];
      json['data'].forEach((v) {
        clientDashboardList!.add(ClientDashboardList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Message'] = this.message;
    data['Success'] = this.success;
    if (this.clientDashboardList != null) {
      data['data'] = this.clientDashboardList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientDashboardList {
  String? client;
  String? client_code;
  String? totalCnt;
  String? triggeredCnt;
  String? pastdueCnt;
  String? probableCnt;
  String? highCnt;
  String? mediumCnt;
  String? lowCnt;
  String? docsInHand;
  String? billedCnt;
  String? unbilledCnt;

  ClientDashboardList(
      {this.client,
        this.client_code,
        this.totalCnt,
        this.triggeredCnt,
        this.pastdueCnt,
        this.probableCnt,
        this.highCnt,
        this.mediumCnt,
        this.lowCnt,
        this.docsInHand,
        this.billedCnt,
        this.unbilledCnt});

  ClientDashboardList.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    client_code = json['client_code'];
    totalCnt = json['total_cnt'].toString();
    triggeredCnt = json['triggered_cnt'].toString();
    pastdueCnt = json['pastdue_cnt'].toString();
    probableCnt = json['probable_cnt'].toString();
    highCnt = json['high_cnt'].toString();
    mediumCnt = json['medium_cnt'].toString();
    lowCnt = json['low_cnt'].toString();
    docsInHand = json['docs_in_hand'].toString();
    billedCnt = json['billed_cnt'].toString();
    unbilledCnt = json['unbilled_cnt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['client'] = this.client;
    data['client_code'] = this.client_code;
    data['total_cnt'] = this.totalCnt;
    data['triggered_cnt'] = this.triggeredCnt;
    data['pastdue_cnt'] = this.pastdueCnt;
    data['probable_cnt'] = this.probableCnt;
    data['high_cnt'] = this.highCnt;
    data['medium_cnt'] = this.mediumCnt;
    data['low_cnt'] = this.lowCnt;
    data['docs_in_hand'] = this.docsInHand;
    data['billed_cnt'] = this.billedCnt;
    data['unbilled_cnt'] = this.unbilledCnt;
    return data;
  }
}