

// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LocationPerms {
//   void requestAccess() async{
//     Map<PermissionGroup, PermissionStatus> permissions =
//         await PermissionHandler().requestPermissions(
//       [PermissionGroup.locationWhenInUse],
//     ).then(
//       (statuses) {
//         final status = statuses[PermissionGroup.locationWhenInUse];

//         if (status == PermissionStatus.granted) {
//           BotToast.showText(
//             text: "Thank you for granting the permission!",
//             contentColor: Theme.of(context).primaryColor,
//           );
//         } else {
//           BotToast.showText(
//             text: "Permission not granted. Please go to your settings to enable location access.",
//             contentColor: Colors.red
//           );
//         }
//       },
//     );
//   }
// }