class FoodData {
  String? sId;
  String? name;
  var originalQuantity;
  String? source;
  var currentQuantity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FoodData(
      {this.sId,
        this.name,
        this.originalQuantity,
        this.source,
        this.currentQuantity,
        this.createdAt,
        this.updatedAt,
        this.iV});

  FoodData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    originalQuantity = json['original_quantity'];
    source = json['source'];
    currentQuantity = json['current_quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['original_quantity'] = this.originalQuantity;
    data['source'] = this.source;
    data['current_quantity'] = this.currentQuantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}