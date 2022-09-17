import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/utils/utils.dart';

class ApiServices {
  // <----- Variable ---->

  // Firebase - Storage
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // Firebase - Cloud FireStore
  static final db = FirebaseFirestore.instance;

  // <---------------------- MONEY ----------------------->
  static Future getTotalMoney(Function callBack) async {
    final docRef = db.collection("money").doc("total_money");
    docRef.snapshots().listen(
      (data) {
        callBack(data.data());
      },
      onError: (error) => callBack(0),
    );
  }

  static Future updateTotalMoney(int total) async {
    await db.collection("money").doc('total_money').update({
      'total': total,
    });
  }

  // <---------------------- NOTE ----------------------->

  // <------------------- Get note today ----------------->
  static Future getNoteToday(Function callBack) async {
    await db
        .collection("notes")
        .where('date', isGreaterThanOrEqualTo: Utils.startToday)
        .where('date', isLessThanOrEqualTo: Utils.endToday)
        .orderBy('date')
        .snapshots()
        .listen(
      (event) {
        callBack(event.docs);
      },
    );
  }

  //  <-------------- Add new note ---------------->
  static Future addNote(
      NoteModel noteModel, TypeModel typeModel, Function callBack) async {
    int totalNew = 0;
    if (typeModel.groupType == Utils.groupType[0]) {
      totalNew = noteModel.money! + Utils.totalMoney;
    } else {
      totalNew = Utils.totalMoney - noteModel.money!;
    }

    await db.collection('notes').add(noteModel.toJson()).then(
      (data) async {
        await db.collection('notes').doc(data.id).update(
          {
            'idNote': data.id,
          },
        );
        await updateTotalMoney(totalNew);
        callBack(true);
      },
      onError: callBack(false),
    );
  }

  // <----- Update note ---->
  static Future updateNote(NoteModel noteModel, TypeModel typeNew,
      TypeModel typeOld, int moneyOld, Function callBack) async {
    print("Start update");
    // <-- Return money -->
    int moneyReturn;
    if (typeOld.groupType == Utils.groupType[0]) {
      moneyReturn = Utils.totalMoney -
          moneyOld; // Nếu là khoản thu thì "Tổng tiền sẽ bị trừ lại"
    } else {
      moneyReturn = Utils.totalMoney +
          moneyOld; // Nếu là chi tiêu thì "Tổng tiền sẽ được cộng lại số tiền đã sử dụng"
    }
    print("Update money old $moneyReturn");
    await updateTotalMoney(moneyReturn);

    // <-- Update new total -->
    int totalNew = 0;
    if (typeNew.groupType == Utils.groupType[0]) {
      totalNew = noteModel.money! + Utils.totalMoney;
    } else {
      totalNew = Utils.totalMoney - noteModel.money!;
    }
    print("Update money new $totalNew");
    await updateTotalMoney(totalNew);

    // <-- Update note -->
    await db.collection("notes").doc(noteModel.idNote).update({
      'money': noteModel.money,
      'note': noteModel.note,
      'type': noteModel.type,
    }).then(
      (value) => (callBack(true)),
      onError: callBack(false),
    );
  }

  // <----- Delete note ---->

  static Future deleteNote(
      NoteModel noteModel, TypeModel typeModel, Function callBack) async {
    // Return lại tiền
    int totalNew;
    if (typeModel.groupType == Utils.groupType[0]) {
      totalNew = Utils.totalMoney -
          noteModel.money!; // Nếu là khoản thu thì "Tổng tiền sẽ bị trừ lại"
    } else {
      totalNew = Utils.totalMoney +
          noteModel
              .money!; // Nếu là chi tiêu thì "Tổng tiền sẽ được cộng lại số tiền đã sử dụng"
    }
    await updateTotalMoney(totalNew);

    db.collection("notes").doc(noteModel.idNote).delete().then(
          (value) => callBack(true),
          onError: callBack(false),
        );
  }

  // <--------------------- TYPES ------------------------->
  // <----- Get single type ---->
  static Future getSingleType(String idType, Function callBack) async {
    db
        .collection("types")
        .doc(idType)
        .get()
        .then((value) => callBack(value.data()));
  }

  // <----- Get list types: Realtime ---->
  static Future getListTypes(Function result) async {
    db.collection("types").snapshots().listen(
      (event) async {
        result(event.docs);
      },
    );
  }

  // <----- Upload image to storage ---->
  static Future<String> uploadImageType(File? fileImageType) async {
    final String nameImageType =
        "ImageType" + Utils.today.millisecondsSinceEpoch.toString();
    final pathStorage = "images/$nameImageType";

    Reference ref = storage.ref().child(pathStorage);
    if (fileImageType == null) {
      return "";
    } else {
      UploadTask? uploadTask = ref.putFile(fileImageType);
      final snapshot = await uploadTask.whenComplete(() => () {});
      // Get URL image
      final urlImage = await snapshot.ref.getDownloadURL();
      return urlImage;
    }
  }

  // <----- Insert type ---->
  static Future insertType(
      TypeModel typeModel, File? fileImageType, Function callBack) async {
    String urlImage = await uploadImageType(fileImageType);

    typeModel.urlType = urlImage;

    await db.collection("types").add(typeModel.toJson()).then((data) {
      db.collection("types").doc(data.id).update(
        {
          'idType': data.id,
        },
      );
      callBack(true);
    }, onError: callBack(false));
  }

  // <----- Update type ---->
  static Future updateType(
      TypeModel typeModel, File? fileImageType, Function callBack) async {
    if (fileImageType != null) {
      await deleteImageURL(typeModel.urlType.toString());
      // String new URL
      typeModel.urlType = await uploadImageType(fileImageType);
    }

    // Map update Type
    Map<String, dynamic> mapUpdate = {
      'contentType': typeModel.contentType,
      'urlType': typeModel.urlType,
    };

    await db
        .collection("types")
        .doc(typeModel.idType)
        .update(mapUpdate)
        .then(
          (value) => callBack(true), // Update type success
        )
        .catchError(
          (e) => callBack(false), // Update type failed
        );
  }

  // <----- Delete image from URL ---->
  static Future deleteImageURL(String url) async {
    if (url.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(url).delete(); // delete failed

    }
  }
}
