class ProviderDataModel {
  String? sId;
  String? name;
  String? email;
  String? userType;
  String? organization;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProviderDataModel(
      {this.sId,
        this.name,
        this.email,
        this.userType,
        this.organization,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProviderDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    organization = json['organization'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userType'] = this.userType;
    data['organization'] = this.organization;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}