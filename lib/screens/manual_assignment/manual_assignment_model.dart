class MainCategoryModel {
  String? message;
  bool? success;
  List<ServicesMainCategoryList>? servicesMainCategoryList;

  MainCategoryModel({this.message, this.success, this.servicesMainCategoryList});

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['servicesMainCategoryList'] != null) {
      servicesMainCategoryList = <ServicesMainCategoryList>[];
      json['servicesMainCategoryList'].forEach((v) {
        servicesMainCategoryList!.add(ServicesMainCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (servicesMainCategoryList != null) {
      data['servicesMainCategoryList'] =
          servicesMainCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesMainCategoryList {
  String? serviceMainCategoryName;
  String? serviceMainCategoryId;

  ServicesMainCategoryList(
      {this.serviceMainCategoryName, this.serviceMainCategoryId});

  ServicesMainCategoryList.fromJson(Map<String, dynamic> json) {
    serviceMainCategoryName = json['service_main_category_name'];
    serviceMainCategoryId = json['service_main_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_main_category_name'] = serviceMainCategoryName;
    data['service_main_category_id'] = serviceMainCategoryId;
    return data;
  }
}