// import 'package:flutter/material.dart';
// import 'package:url_launcher/link.dart';
// import 'package:url_launcher/url_launcher_string.dart';
//
// class SocialIcons extends StatelessWidget {
//   final String name;
//   final String linkName;
//
//
//    const SocialIcons({
//     super.key,
//     required this.name,
//     required this.linkName,
// });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Link(
//         uri: Uri.parse(linkName),
//         target: LinkTarget.blank,
//         builder: (context,followLink) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: CircleAvatar(
//             radius: 35,
//             child: Material(
//               shape: CircleBorder(),
//               clipBehavior: Clip.hardEdge,
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: followLink,
//                 child: Center(
//                   child: Image.asset(name),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ),
//     );
//   }
// }
