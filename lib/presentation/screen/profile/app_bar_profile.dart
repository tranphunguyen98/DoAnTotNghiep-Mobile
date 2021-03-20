// import 'package:flutter/material.dart';
//
// class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
//   final double height;
//
//   const AppBarProfile({
//     Key key,
//     @required this.height,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.grey[300],
//           child: Padding(
//             padding: EdgeInsets.all(30),
//             child: AppBar(
//               title: Container(
//                 color: Colors.white,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search",
//                     contentPadding: EdgeInsets.all(10),
//                   ),
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.verified_user),
//                   onPressed: () => null,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }
