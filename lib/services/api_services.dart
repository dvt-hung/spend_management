import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/utils/utils.dart';

class ApiServices {
  // <----- Variable ---->

  // Firebase - Storage
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // Firebase - Cloud FireStore
  static final db = FirebaseFirestore.instance;

  // <--------------------- TYPES ------------------------->
  // static Future<List<QueryDocumentSnapshot>> getTypes(
  //     Function finish, Function catchError) async {
  //   List<QueryDocumentSnapshot> snapshot = await db
  //       .collection("types")
  //       .withConverter<TypeModel>(
  //         fromFirestore: (snapshot, _) => TypeModel.fromJson(snapshot.data()),
  //         toFirestore: (data, _) => data.toJson(),
  //       )
  //       .get()
  //       .then((snapshot) => snapshot.docs)
  //       .catchError((error) => catchError(error));
  //   finish(snapshot);
  //
  //   return snapshot;
  // }

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
