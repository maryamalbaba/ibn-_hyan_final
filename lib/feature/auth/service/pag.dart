// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';

// class ObtainDeviceid extends StatelessWidget {
//   const ObtainDeviceid({super.key});

//   Future<String?> getAndroidId() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     // String andridd = androidInfo.id; 
//     // return andridd;// Unique ID for each Android device
//  if (Platform.isAndroid) {
   
//    AndroidDeviceInfo androidinf= await deviceInfo.androidInfo;
//    return androidinf.id;
//  } else if(Platform.isWindows) {
//    WindowsDeviceInfo windowsinfo= await deviceInfo.windowsInfo;
//    return windowsinfo.computerName;
//  }
//  else{
//   return "12345678";
//  }
 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder(
//             future: getAndroidId(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Center(child: Text("${snapshot.data}"));
//               } else {
//                 return CircularProgressIndicator();
//               }
//             }));
//   }
// }
