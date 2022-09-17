class TypeModel {
  String? idType;
  String? urlType;
  String? contentType;
  String? groupType;

  TypeModel({this.idType, this.urlType, this.contentType, this.groupType});

  TypeModel.fromJson(dynamic json) {
    idType = json['idType'] ?? '';
    urlType = json['urlType'] ?? '';
    contentType = json['contentType'] ?? '';
    groupType = json['groupType'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['idType'] = idType;
    map['urlType'] = urlType;
    map['contentType'] = contentType;
    map['groupType'] = groupType;
    return map;
  }
}
