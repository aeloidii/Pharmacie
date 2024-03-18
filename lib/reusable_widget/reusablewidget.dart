import 'package:adminsignin/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit:BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,


  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(

    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),

      suffixIcon: isPasswordType ? GestureDetector(onTap:(){
        isPasswordType=!isPasswordType;
      }

          ,child: Icon(isPasswordType ? Icons.visibility: Icons.visibility_off)
      ): Text(""),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}




TextField reusableTextFieldAdd(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, bool edit) {
  return TextField(
    enabled: edit,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: AppColors.them,
    style: TextStyle(color: AppColors.them),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.them.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}


TextField reusableTextFieldDate(String text, IconData icon, bool isPasswordType,
    TextEditingController controller,Function onTap) {
  return TextField(

    controller: controller,
    cursorColor: AppColors.them,
    style: TextStyle(color: AppColors.them),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.them.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: TextInputType.datetime,readOnly: true,
    onTap: () {
        onTap();
      },
  );
}



TextField smallTextFieldAdd(String text, bool isPasswordType,
    TextEditingController controller, bool edit) {
  return TextField(
      enabled: edit,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: AppColors.them,
      style: TextStyle(color: AppColors.them,fontSize: 14),
      decoration: InputDecoration(

        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.them.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    )
  ;
}


Expanded editTextFieldAdd(String text, bool isPasswordType,
    TextEditingController controller, bool edit) {
  return Expanded(
    child: TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      enabled: edit,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: AppColors.them,
      style: TextStyle(color: AppColors.them,fontSize: 14),
      decoration: InputDecoration(

        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.them.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      // keyboardType: isPasswordType
      //     ? TextInputType.visiblePassword
      //     : TextInputType.emailAddress,
    ),
  )
  ;
}


// TextField reusableTextFieldAddAut(String text, IconData icon, bool isPasswordType,
//     TextEditingController controller, bool edit, Function onChange) {
//   return TextField(
//     enabled: edit,
//     controller: controller,
//     obscureText: isPasswordType,
//     enableSuggestions: !isPasswordType,
//     autocorrect: !isPasswordType,
//     cursorColor: AppColors.them,
//     style: TextStyle(color: AppColors.them),
//     decoration: InputDecoration(
//       prefixIcon: Icon(
//         icon,
//         color: Colors.white,
//       ),
//       labelText: text,
//       labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
//       filled: true,
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       fillColor: AppColors.them.withOpacity(0.3),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
//     ),
//     keyboardType: isPasswordType
//         ? TextInputType.visiblePassword
//         : TextInputType.emailAddress,
//
//     onChanged: (value) {
//       onChange();
//     },
//
//
//   );
// }


Container firebaseUIButton(BuildContext context, String title, Function onTap, Color colbg, Color colTxt) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style:  TextStyle(
            color: colTxt , fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            // var col=Colors.white;
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return colbg;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}


// class imagePicker extends StatefulWidget {
//   @override
//   State<imagePicker> createState() => _imagePickerState();
// }
//
// class _imagePickerState extends State<imagePicker> {
//   String selectedImagePath = '';
//
//   @override
//   Widget build(BuildContext context) {
//
//           return Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)), //this right here
//             child: Container(
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Select Image From !',
//                       style: TextStyle(
//                           fontSize: 18.0, fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             selectedImagePath = await selectImageFromGallery();
//                             print('Image_Path:-');
//                             print(selectedImagePath);
//                             if (selectedImagePath != '') {
//                               Navigator.pop(context);
//                               setState(() {});
//                             } else {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text("No Image Selected !"),
//                               ));
//                             }
//                           },
//                           child: Card(
//                               elevation: 5,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/gallery.png',
//                                       height: 60,
//                                       width: 60,
//                                     ),
//                                     Text('Gallery'),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             selectedImagePath = await selectImageFromCamera();
//                             print('Image_Path:-');
//                             print(selectedImagePath);
//
//                             if (selectedImagePath != '') {
//                               Navigator.pop(context);
//                               setState(() {});
//                             } else {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text("No Image Captured !"),
//                               ));
//                             }
//                           },
//                           child: Card(
//                               elevation: 5,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/camera.png',
//                                       height: 60,
//                                       width: 60,
//                                     ),
//                                     Text('Camera'),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//
//   }
//
//   selectImageFromGallery() async {
//     XFile? file =  ImagePicker()
//         .pickImage(source: ImageSource.gallery, imageQuality: 10) as XFile?;
//     if (file != null) {
//       return file.path;
//     } else {
//       return '';
//     }
//   }
//
// //
//   selectImageFromCamera() async {
//     XFile? file = await ImagePicker()
//         .pickImage(source: ImageSource.camera, imageQuality: 10);
//     if (file != null) {
//       return file.path;
//     } else {
//       return '';
//     }
//   }
//
// }



class dropdown{
  static Widget dropDownWidget(
      BuildContext context,
      String hintText,
      dynamic value,
      List<dynamic> lstData,
      Function onChanged,
      Function onValidate, {
        double hintFontSize = 15,
        // Color borderColor = Colors.redAccent,
        double borderRadius = 30,
        // Color borderFocusColor = Colors.redAccent,
        double paddingLeft = 20,
        double paddingRight = 20,
        double paddingTop = 0,
        double paddingBottom = 0,
        String optionValue = "id",
        String optionLabel = "name",
        double contentPadding = 6,
        Color validationColor = Colors.redAccent,
        Color textColor = Colors.black,
        Color hintColor = Colors.black,
        double borderWidth = 0,
        double focusedBorderWidth = 0,
        double enabledBorderWidth = 0,
        Widget? suffixIcon,
        Icon? prefixIcon,
        bool showPrefixIcon = false,
        Color prefixIconColor = Colors.redAccent,
        double prefixIconPaddingLeft = 30,
        double prefixIconPaddingRight = 10,
        double prefixIconPaddingTop = 0,
        double prefixIconPaddingBottom = 0,
      }) {
    if (value != "") {
      var findValue = lstData
          .where((item) => item[optionValue].toString() == value.toString());

      if (findValue.length > 0) {
        value = findValue.first[optionValue].toString();
      } else {
        value = null;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: FormField<dynamic>(
        builder: (FormFieldState<dynamic> state) {
          return DropdownButtonFormField<String>(
            isExpanded: true,
            value: value != "" ? value : null,
            isDense: true,
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: hintFontSize,
              ),
            ),
            decoration: InputDecoration(
              // fillColor: AppColors.them.withOpacity(0.3),
              contentPadding: EdgeInsets.all(contentPadding),
              errorStyle: TextStyle(
                color: validationColor,
              ),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: hintFontSize,
                color: hintColor,
              ),
              fillColor: Colors.amber,
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     // color: borderFocusColor,
              //     // width: focusedBorderWidth,
              //   ),
              //   borderRadius: BorderRadius.circular(borderRadius),
              // ),
              suffixIcon: suffixIcon,
              prefixIcon: showPrefixIcon
                  ? Padding(
                child: IconTheme(
                  data: IconThemeData(color: prefixIconColor),
                  child: prefixIcon!,
                ),
                padding: EdgeInsets.only(
                  left: prefixIconPaddingLeft,
                  right: prefixIconPaddingRight,
                  top: prefixIconPaddingTop,
                  bottom: prefixIconPaddingBottom,
                ),
              )
                  : null,
            ),
            // decoration: InputDecoration(
            //   contentPadding: EdgeInsets.all(contentPadding),
            //   hintStyle: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: hintFontSize,
            //   ),
            //   enabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(borderRadius),
            //     borderSide: BorderSide(
            //       color: borderColor,
            //       width: 1,
            //     ),
            //   ),
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(borderRadius),
            //     borderSide: BorderSide(
            //       color: borderColor,
            //       width: 2,
            //     ),
            //   ),
            //   focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(
            //       color: borderFocusColor,
            //       width: 2.0,
            //     ),
            //     borderRadius: BorderRadius.circular(borderRadius),
            //   ),
            // ),
            onChanged: (newValue) {
              //  FocusScope.of(context).requestFocus(new FocusNode());
              state.didChange(newValue);
              return onChanged(newValue);
            },
            validator: (value) {
              return onValidate(value);
            },
            items: lstData.map<DropdownMenuItem<String>>(
                  (dynamic data) {
                return DropdownMenuItem<String>(
                  value: data[optionValue].toString(),
                  child: new Text(
                    data[optionLabel],
                    style: new TextStyle(color: Colors.white, fontSize: 13),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
  static dropDownWidgetWithLabel(
      BuildContext context,
      String labelName,
      String hintText,
      dynamic value,
      List<dynamic> lstData,
      Function onChanged,
      Function onValidate, {
        double labelFontSize: 20,
        bool labelBold = true,
        double hintFontSize = 15,
        // Color borderColor = Colors.redAccent,
        double borderRadius = 30,
        // Color borderFocusColor = Colors.redAccent,
        double paddingLeft = 0,
        double paddingRight = 0,
        double paddingTop = 0,
        double paddingBottom = 0,
        String optionValue = "id",
        String optionLabel = "name",
        double contentPadding = 6,
        // Color validationColor = Colors.redAccent,
        Color textColor = Colors.white,
        Color hintColor = Colors.white,
        double borderWidth = 0.0,
        double focusedBorderWidth = 0.0,
        double enabledBorderWidth = 0.0,
        Widget? suffixIcon,
        Icon? prefixIcon,
        bool showPrefixIcon = true,
        Color prefixIconColor = Colors.white,
        double prefixIconPaddingLeft = 30,
        double prefixIconPaddingRight = 10,
        double prefixIconPaddingTop = 0,
        double prefixIconPaddingBottom = 0,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(

          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(
                left: 0,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  labelName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: labelBold ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
            dropDownWidget(
              context,
              hintText,
              value,
              lstData,
              onChanged,
              onValidate,
              hintFontSize: hintFontSize,

              borderRadius: borderRadius,
              paddingLeft: paddingLeft,
              paddingRight: paddingRight,
              paddingTop: paddingTop,
              paddingBottom: paddingBottom,
              optionValue: optionValue,
              optionLabel: optionLabel,
              contentPadding: contentPadding,
              textColor: textColor,
              hintColor: hintColor,
              borderWidth: borderWidth,
              focusedBorderWidth: 0.0,
              enabledBorderWidth: 0.0,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              showPrefixIcon: showPrefixIcon,
              prefixIconColor: prefixIconColor,
              prefixIconPaddingLeft: prefixIconPaddingLeft,
              prefixIconPaddingRight: prefixIconPaddingRight,
              prefixIconPaddingTop: prefixIconPaddingTop,
              prefixIconPaddingBottom: prefixIconPaddingBottom,
            )
          ],
        ),
      ),
    );
  }
}

TextField reusableTextFieldAddselect(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(

    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: AppColors.them,
    style: TextStyle(color: AppColors.them),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      suffixIcon: Icon(
        Icons.arrow_drop_down_outlined,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.them.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}