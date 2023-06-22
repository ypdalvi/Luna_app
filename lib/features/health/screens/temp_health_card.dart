// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:luna/features/health/controller/health_controller.dart';

// class TempHealthCardScreen extends ConsumerStatefulWidget {
//   const TempHealthCardScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _HealthCardScreenState();
// }

// class _HealthCardScreenState extends ConsumerState<TempHealthCardScreen> {
//   final question = ["is there period?", "how are you ? "];
//   final answers = [
//     ['yes', 'no'],
//     ['fine', 'okay']
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final healthCard = ref.watch(healthModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Show Question"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           child: Column(
//             children: <Widget>[
//               ListView.builder(
//                 itemCount: question.length,
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: Container(
//                       width: double.infinity,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               offset: Offset(4, 4),
//                               blurRadius: 10,
//                               color: Colors.grey.withOpacity(.5),
//                             ),
//                             BoxShadow(
//                               offset: Offset(-3, 0),
//                               blurRadius: 15,
//                               color: Color(0xffb8bfce).withOpacity(.5),
//                             ),
//                           ]),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             question[index],
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 25,
//                                 color: Colors.black),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               ...answers[index].map(
//                                 (e) => Expanded(
//                                   child: Text(
//                                     e.toString(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 child: Text("Answer: "),
//                                 padding: EdgeInsets.only(top: 5),
//                               ),
//                               Padding(
//                                 child: Text(
//                                   "answer",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 padding: EdgeInsets.only(top: 5),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Padding(
//                                 child: Icon(
//                                   Icons.check_circle,
//                                   color: Colors.green,
//                                 ),
//                                 padding: EdgeInsets.only(top: 2),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Container()
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
