// import 'dart:io';
//
// import 'package:adminsignin/reusable_widget/loading.dart';
// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:adminsignin/profile/model/user.dart';
// import 'package:adminsignin/profile/utils/user_preferences.dart';
// import 'package:adminsignin/profile/widget/appbar_widget.dart';
// import 'package:adminsignin/profile/widget/button_widget.dart';
// import 'package:adminsignin/profile/widget/profile_widget.dart';
// import 'package:adminsignin/profile/widget/textfield_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_quill/flutter_quill.dart';
//
//
//
// class EditProfilePage extends StatefulWidget {
//   String docId;
//   EditProfilePage({super.key, required this.docId});
//
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   // UserAd user = UserPreferences.myUser;
//   QuillController _controller = QuillController.basic();
//   String  name='';
//
//   String  email='';
//   String  about='';
//
//   String  image='';
//   @override
//   Widget build(BuildContext context) => Builder(
//     builder: (context) => Scaffold(
//       appBar: buildAppBar(context),
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('employee').doc(widget.docId).snapshots(),
//           builder: (context, snapshot) {
//
//           if (snapshot.hasData) {
//             name=snapshot.data!["nom"];
//             image=snapshot.data!["ImagePath"];
//             email=snapshot.data!["email"];
//             about=snapshot.data!["à_propos"];
//             return ListView(
//               padding: EdgeInsets.symmetric(horizontal: 32),
//               physics: BouncingScrollPhysics(),
//               children: [
//                 ProfileWidget(
//                   imagePath: image,
//                   isEdit: true,
//                   onClicked: () async {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'Full Name',
//                   text: name,
//                   onChanged: (name) {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'Email',
//                   text: email,
//                   onChanged: (email) {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'About',
//                   text: about,
//                   maxLines: 5,
//                   onChanged: (about) {},
//                 ),
//
//               ],
//             );
//           }
//
//           return Loading();
//
//           }
//       ),
//     ),
//   );
// }
