import 'dart:math';

import 'package:bianat_app/app/style/app_style.dart';
import 'package:bianat_app/controller/auth_controller.dart';
import 'package:bianat_app/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../view/widgets/widgets.dart';

class HomeController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  late User user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController, contentController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  late CollectionReference collectionReferenceForUser;
  RxList<Note> notes = RxList<Note>([]);
  Random random = Random();
  String appLink = '';

  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
    titleController = TextEditingController();
    contentController = TextEditingController();
    collectionReference = firebaseFirestore.collection('Notes');
    collectionReferenceForUser = firebaseFirestore.collection('Notes')
      ..where('user_id', isEqualTo: user.uid);
    notes.bindStream(getAllNotes());
    getAppLink();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    contentController.dispose();
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return 'Title can not be empty';
    }
    return null;
  }

  String? validateContent(String value) {
    if (value.isEmpty) {
      return 'Content can not be empty';
    }
    return null;
  }

  void addNoteToFirebase(
      String title, String content, int? addEditFlage, String? docId) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    CustomFullScreenDialog.cancelDialog();
    if (addEditFlage == 1) {
      CustomFullScreenDialog.showDialog();
      collectionReference.add({
        'note_title': title,
        'note_content': content,
        'color_id': random.nextInt(AppStyle.cardsColor.length),
        'creation_date': DateTime.now(),
        'user_id': user.uid,
        'user_name': user.displayName,
        'share_with_users': [],
      }).whenComplete(() {
        clearEditingController();
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Note Added',
            message: 'Note Added Successfully',
            backgroundColor: Colors.green);
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Error',
            message: 'Something went wrong',
            backgroundColor: Colors.red);
      });
    } else if (addEditFlage == 2) {
      CustomFullScreenDialog.showDialog();
      collectionReference.doc(docId).update({
        'note_title': title,
        'note_content': content,
        'creation_date': DateTime.now(),
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: 'Note Updated',
          message: 'Note Updated Successfully',
          backgroundColor: Colors.green,
        );
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: 'Error',
          message: 'Somthing went wrong',
          backgroundColor: Colors.red,
        );
      });
    }
  }

  void deleteData(String id) {
    collectionReference.doc(id).delete().whenComplete(() {
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: 'Note Deleted',
        message: 'Note Deleted Successfully',
        backgroundColor: Colors.green,
      );
    }).catchError((error) {
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: 'Error',
        message: 'Somthing went wrong',
        backgroundColor: Colors.red,
      );
    });
  }

  void clearEditingController() {
    titleController.clear();
    contentController.clear();
  }

  Stream<List<Note>> getAllNotes() {
    return collectionReferenceForUser
        .orderBy('creation_date', descending: true)
        .snapshots()
        .map((query) => query.docs.map((item) => Note.fromJson(item)).toList());
  }

  Future getAppLink() {
    return firebaseFirestore.collection('AppLink').limit(1).get().then(
      (value) {
        appLink = value.docs[0]['app_link'];
      },
    );
  }

  void shareContent(String noteTitle, String noteContent) async {
    String appUrl = appLink;
    await Share.share(
      'Note title: $noteTitle\nNote content: $noteContent\n\nJoin us: $appUrl',
    );
  }
}
