class TypeModel {
  String? idType;
  String? urlType;
  String? contentType;

  TypeModel({this.idType, this.urlType, this.contentType});

  TypeModel.fromJson(dynamic json) {
    idType = json['idType'] ?? '';
    urlType = json['urlType'] ?? '';
    contentType = json['contentType'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['idType'] = idType;
    map['urlType'] = urlType;
    map['contentType'] = contentType;
    return map;
  }
}
