import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spend_management/models/type_model.dart';

class NoteModel {
  String? idNote;
  String? type;
  int? money;
  Timestamp? date;
  String? note;

  NoteModel({
    this.idNote,
    this.type,
    this.money,
    this.date,
    this.note,
  });

  NoteModel.fromJson(dynamic json) {
    idNote = json['idNote'] ?? '';
    type = json['type'] ?? '';
    money = json['money'] ?? '';
    date = json['date'] ?? '';
    note = json['note'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['idNote'] = idNote;
    map['type'] = type;
    map['money'] = money;
    map['date'] = date;
    map['note'] = note;
    return map;
  }
}
