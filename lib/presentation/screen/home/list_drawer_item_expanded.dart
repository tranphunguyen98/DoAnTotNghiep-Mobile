// import 'package:flutter/material.dart';
//
// class ListDrawerItemExpanded extends StatefulWidget {
//   ListDrawerItemExpandedState createState() => ListDrawerItemExpandedState();
// }
//
// class ItemExpanded {
//   bool isExpanded;
//   final String header;
//   final Widget body;
//   final Icon icon;
//   ItemExpanded(this.isExpanded, this.header, this.body, this.icon);
// }
//
// class ListDrawerItemExpandedState extends State<ListDrawerItemExpanded> {
//   List<ItemExpanded> items = <ItemExpanded>[
//     ItemExpanded(
//         false, // isExpanded ?
//         'Header', // header
//         Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(children: <Widget>[
//               Text('data'),
//               Text('data'),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text('data'),
//                   Text('data'),
//                   Text('data'),
//                 ],
//               ),
//               Radio(value: null, groupValue: null, onChanged: null)
//             ])), // body
//         Icon(Icons.image) // iconPic
//         ),
//     ItemExpanded(
//         false, // isExpanded ?
//         'Header1', // header
//         Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(children: <Widget>[
//               Text('data'),
//               Text('data'),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text('data'),
//                   Text('data'),
//                   Text('data'),
//                 ],
//               ),
//               Radio(value: null, groupValue: null, onChanged: null)
//             ])), // body
//         Icon(Icons.image) // iconPic
//         ),
//   ];
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: ExpansionPanelList(
//             elevation: 0,
//             dividerColor: Colors.transparent,
//             expandedHeaderPadding: EdgeInsets.zero,
//             expansionCallback: (int index, bool isExpanded) {
//               setState(() {
//                 items[index].isExpanded = !items[index].isExpanded;
//               });
//             },
//             children: items.map((ItemExpanded item) {
//               return ExpansionPanel(
//                 headerBuilder: (BuildContext context, bool isExpanded) {
//                   return ListTile(
//                       leading: item.icon,
//                       title: Text(
//                         item.header,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ));
//                 },
//                 isExpanded: item.isExpanded,
//                 body: item.body,
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
