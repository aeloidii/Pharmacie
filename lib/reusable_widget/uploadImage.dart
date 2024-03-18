// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';
//
//
//
// // import 'firebase_options.dart';
//
// // void main() async {
// //   // Initialize Firebase
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //
// //   // Run the app
// //   runApp(MyApp());
// // }
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MediaQuery(
// //       data: MediaQueryData(),
// //       child: MaterialApp(
// //         home: CircularImagePicker(),
// //       ),
// //     );
// //   }
// // }
//
// class CircularImagePicker extends StatefulWidget {
//   @override
//   _CircularImagePickerState createState() => _CircularImagePickerState();
// }
//
// class _CircularImagePickerState extends State<CircularImagePicker> {
//   File? _imageFile;
//   final picker = ImagePicker();
//
//   Future getImageFromCamera() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       _imageFile = File(pickedFile!.path);
//
//     });
//
//     // Call uploadImageToFirestore here
//     await uploadImageToFirestore(_imageFile!);
//   }
//
//   Future getImageFromGallery() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       _imageFile = File(pickedFile!.path);
//
//     });
//
//     // Call uploadImageToFirestore here
//     await uploadImageToFirestore(_imageFile!);
//   }
//   Future getImageFromWeb() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);
//     if (result != null) {
//       final bytes = result.files.single.bytes!;
//       final directory = await getApplicationDocumentsDirectory();
//       final imageFile = File('${directory.path}/${result.files.single.name}.jpg');
//       await imageFile.writeAsBytes(bytes);
//       setState(() {
//         _imageFile = imageFile;
//       });
//       await uploadImageToFirestore(_imageFile!);
//     }
//   }
//
//
//
//
//
//
//   Future uploadImageToFirestore(File imageFile) async {
//     // Upload the image to Firebase Storage
//     final storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
//     final uploadTask = storageReference.putFile(imageFile);
//     final downloadUrl = await (await uploadTask).ref.getDownloadURL();
//
//     // Save the image URL to Firebase Firestore
//     final documentReference = FirebaseFirestore.instance.collection('images').doc();
//     await documentReference.set({'imageUrl': downloadUrl});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Circular Image Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 if (kIsWeb) {
//                   getImageFromWeb();
//                 } else {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         height: 150.0,
//                         child: Column(
//                           children: [
//                             ListTile(
//                               leading: Icon(Icons.camera_alt),
//                               title: Text('Take a picture'),
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 getImageFromCamera();
//                               },
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.photo_album),
//                               title: Text('Choose from gallery'),
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 getImageFromGallery();
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//               child: CircleAvatar(
//                 radius: 75,
//                 backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
//               ),
//             ),
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> getImageFromCamera(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      await uploadImageToFirestore(context, _imageFile!);
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      await uploadImageToFirestore(context, _imageFile!);
    }
  }

  Future<void> getImageFromWeb(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final bytes = result.files.single.bytes!;
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/${result.files.single.name}.jpg');
      await imageFile.writeAsBytes(bytes);

      _imageFile = imageFile;

      await uploadImageToFirestore(context, _imageFile!);
    }
  }

  Future<void> uploadImageToFirestore(BuildContext context, File imageFile) async {
    final storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
    final uploadTask = storageReference.putFile(imageFile);
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    final documentReference = FirebaseFirestore.instance.collection('images').doc();
    await documentReference.set({'imageUrl': downloadUrl});

    // Show a success message or perform other actions
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image uploaded successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (kIsWeb) {
              getImageFromWeb(context);
            } else {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 150.0,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Take a picture'),
                          onTap: () {
                            Navigator.pop(context);
                            getImageFromCamera(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_album),
                          title: Text('Choose from gallery'),
                          onTap: () {
                            Navigator.pop(context);
                            getImageFromGallery(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          child: Text('Select Image'),
        ),
      ),
    );
  }
}
