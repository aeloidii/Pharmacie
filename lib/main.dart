import 'package:adminsignin/component/employees.dart';
import 'package:adminsignin/provider/villeProvider.dart';
import 'package:adminsignin/screens/signin_screen.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 Firebase.initializeApp(options: const FirebaseOptions( apiKey: "AIzaSyCOkJK7dUQSOVgPAaMRwKzFaISxNZ0nEAY", appId: "1:476389088144:web:2a529eac97193264eeb115", messagingSenderId: "476389088144", projectId: "adminflutter-5b73b", storageBucket: "adminflutter-5b73b.appspot.com", ), );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          hourMinuteShape: const CircleBorder(),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xDD0C4E4A, AppColors.color))
            .copyWith(secondary: Colors.greenAccent),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
      ),
      // home: const SignInScreen(),
      home:  SignInScreen(),
    );
  }
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider<ProductProvider>(
  //         create: (context) => ProductProvider(),
  //       ),
  //     ],
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //
  //         timePickerTheme: TimePickerThemeData(
  //           backgroundColor: Colors.white,
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           hourMinuteShape: const CircleBorder(),
  //         ),
  //         colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xDD0C4E4A, AppColors.color))
  //             .copyWith(secondary: Colors.greenAccent),
  //         // This is the theme of your application.
  //         //
  //         // Try running your application with "flutter run". You'll see the
  //         // application has a blue toolbar. Then, without quitting the app, try
  //         // changing the primarySwatch below to Colors.green and then invoke
  //         // "hot reload" (press "r" in the console where you ran "flutter run",
  //         // or simply save your changes to "hot reload" in a Flutter IDE).
  //         // Notice that the counter didn't reset back to zero; the application
  //         // is not restarted.
  //         // primarySwatch: Colors.blue,
  //       ),
  //       // home: const SignInScreen(),
  //       home:  employees(),
  //     ),
  //   );
  // }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SignInScreen(),
//         '/second': (context) => Dashboard(),
//       },
//       theme: ThemeData(
//
//         timePickerTheme: TimePickerThemeData(
//           backgroundColor: Colors.white,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           hourMinuteShape: const CircleBorder(),
//         ),
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xDD0C4E4A, AppColors.color))
//             .copyWith(secondary: Colors.greenAccent),
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         // primarySwatch: Colors.blue,
//       ),
//       // home: const SignInScreen(),
//       // home:  SignInScreen(),
//     );
//   }
// // Widget build(BuildContext context) {
// //   return MultiProvider(
// //     providers: [
// //       ChangeNotifierProvider<ProductProvider>(
// //         create: (context) => ProductProvider(),
// //       ),
// //     ],
// //     child: MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //
// //         timePickerTheme: TimePickerThemeData(
// //           backgroundColor: Colors.white,
// //           shape:
// //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //           hourMinuteShape: const CircleBorder(),
// //         ),
// //         colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xDD0C4E4A, AppColors.color))
// //             .copyWith(secondary: Colors.greenAccent),
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         // primarySwatch: Colors.blue,
// //       ),
// //       // home: const SignInScreen(),
// //       home:  employees(),
// //     ),
// //   );
// // }
// }
