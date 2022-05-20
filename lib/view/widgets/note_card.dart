// import 'package:bianat_app/app/style/app_style.dart';
// import 'package:bianat_app/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class NoteCards extends GetView<HomeController> {
//   const NoteCards({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Expanded(
//         child: ListView.builder(
//           itemCount: controller.notes.length,
//           itemBuilder: (context, index) {
//             DateTime date = DateTime.parse(
//                 controller.notes[index].timestamp!.toDate().toString());

//             return Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color:
//                     AppStyle.cardsColor[controller.notes[index].colorNumber!],
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(8),
//                   onTap: () {
//                     // Get.defaultDialog(
//                     //   title: 'Edit Note',
//                     //   content: Column(
//                     //     children: [
//                     //       TextFormField(
//                     //         decoration: InputDecoration(
//                     //           labelText: controller.notes[index].content,
//                     //           focusedBorder: OutlineInputBorder(
//                     //             borderRadius: BorderRadius.circular(25.0),
//                     //             borderSide: const BorderSide(
//                     //               color: Colors.blue,
//                     //             ),
//                     //           ),
//                     //           enabledBorder: OutlineInputBorder(
//                     //             borderRadius: BorderRadius.circular(25.0),
//                     //             borderSide: const BorderSide(
//                     //               color: Color(0xFF8B80F8),
//                     //               width: 2.0,
//                     //             ),
//                     //           ),
//                     //         ),
//                     //         maxLines: null,
//                     //       ),
//                     //       const SizedBox(
//                     //         height: 16,
//                     //       ),
//                     //       SizedBox(
//                     //         width: 100,
//                     //         child: ElevatedButton(
//                     //           onPressed: () {},
//                     //           child: Text('Edit'),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // );
//                     controller.titleController.text =controller.notes[index].title!;
//                     controller.contentController.text =controller.notes[index].content!;
                    
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           controller.notes[index].title!,
//                           style: AppStyle.mainTitle,
//                         ),
//                         Text(
//                           DateFormat('MM/dd/yyyy hh:mm a').format(date),
//                           style: AppStyle.dateTitle,
//                         ),
//                         Text(
//                           controller.notes[index].content!,
//                           style: AppStyle.mainContent,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
