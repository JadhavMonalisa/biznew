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
    serviceMainCategoryId = json['service_service_main_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_main_category_name'] = serviceMainCategoryName;
    data['service_service_main_category_id'] = serviceMainCategoryId;
    return data;
  }
}

class ServicesFromMainCategoryModel {
  String? message;
  bool? success;
  List<ServicesList>? servicesList;

  ServicesFromMainCategoryModel({this.message, this.success, this.servicesList});

  ServicesFromMainCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['servicesList'] != null) {
      servicesList = <ServicesList>[];
      json['servicesList'].forEach((v) {
        servicesList!.add(ServicesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (servicesList != null) {
      data['servicesList'] = servicesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesList {
  String? serviceId;
  String? serviceName;

  ServicesList({this.serviceId, this.serviceName});

  ServicesList.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    return data;
  }
}

class ManualAssignmentTaskModel {
  String? message;
  bool? success;
  List<ManualAssignmentTaskDetails>? manualAssignmentTaskDetails;

  ManualAssignmentTaskModel({this.message, this.success, this.manualAssignmentTaskDetails});

  ManualAssignmentTaskModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      manualAssignmentTaskDetails = <ManualAssignmentTaskDetails>[];
      json['data'].forEach((v) {
        manualAssignmentTaskDetails!.add(ManualAssignmentTaskDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (manualAssignmentTaskDetails != null) {
      data['data'] = manualAssignmentTaskDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManualAssignmentTaskDetails {
  String? taskName;
  String? taskId;
  String? sortno;
  String? completion;
  String? days;
  String? hours;
  String? minutes;

  ManualAssignmentTaskDetails(
      {this.taskName,
        this.taskId,
        this.sortno,
        this.completion,
        this.days,
        this.hours,
        this.minutes});

  ManualAssignmentTaskDetails.fromJson(Map<String, dynamic> json) {
    taskName = json['task_name'];
    taskId = json['task_id'];
    sortno = json['sortno'];
    completion = json['completion'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_name'] = taskName;
    data['task_id'] = taskId;
    data['sortno'] = sortno;
    data['completion'] = completion;
    data['days'] = days;
    data['hours'] = hours;
    data['minutes'] = minutes;
    return data;
  }
}