import 'package:bianat_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bianat_app/app/style/app_style.dart';
import 'package:intl/intl.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Bianat Task'),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        actions: [
          IconButton(
            onPressed: () {
              _buildAddEditNoteView(
                text: 'Add',
                addEditFlag: 1,
              );
              controller.titleController.text = '';
              controller.contentController.text = '';
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${controller.user.displayName}',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              'Your Recet Notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: (controller.notes.isEmpty)
                    ? const Center(
                        child: Text(
                          'There\'s No Notes Yet.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.notes.length,
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.parse(controller
                              .notes[index].timestamp!
                              .toDate()
                              .toString());

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppStyle.cardsColor[
                                  controller.notes[index].colorNumber!],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  controller.titleController.text =
                                      controller.notes[index].title!;
                                  controller.contentController.text =
                                      controller.notes[index].content!;
                                  _buildAddEditNoteView(
                                    text: 'Update',
                                    addEditFlag: 2,
                                    docId: controller.notes[index].id,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.notes[index].userName!,
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            controller.notes[index].title!,
                                            style: AppStyle.mainTitle,
                                          ),
                                          Text(
                                            DateFormat('MM/dd/yyyy hh:mm a')
                                                .format(date),
                                            style: AppStyle.dateTitle,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            controller.notes[index].content!,
                                            style: AppStyle.mainContent,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteData(
                                                  controller.notes[index].id!);
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAddEditNoteView({String? text, int? addEditFlag, String? docId}) {
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text == 'Update'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: docId));
                                Get.snackbar('Copied',
                                    'The note id had been copied successfully.',
                                    colorText: Colors.green);
                              },
                              child: const Text(
                                'Share this note',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Text(
                    '${text} Note',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.titleController,
                    validator: (value) {
                      return controller.validateTitle(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Content',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: controller.contentController,
                    validator: (value) {
                      return controller.validateContent(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: Get.context!.width,
                      height: 45,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        controller.addNoteToFirebase(
                          controller.titleController.text,
                          controller.contentController.text,
                          addEditFlag!,
                          docId,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
