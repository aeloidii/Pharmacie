import 'dart:io';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:adminsignin/profile/model/user.dart';
import 'package:adminsignin/profile/utils/user_preferences.dart';
import 'package:adminsignin/profile/widget/appbar_widget.dart';
import 'package:adminsignin/profile/widget/button_widget.dart';
import 'package:adminsignin/profile/widget/profile_widget.dart';
import 'package:adminsignin/profile/widget/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:adminsignin/colorutils.dart';

import '../reusable_widget/reusablewidget.dart';
import '../style/colors.dart';
import '../style/style.dart';


class EditInfoPage extends StatefulWidget {
  String docId;
  EditInfoPage({super.key, required this.docId});

  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  // UserAd user = UserPreferences.myUser;
  QuillController _controller = QuillController.basic();
  String  name='';
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;

  TextEditingController _desigTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _faxTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _ribTextController = TextEditingController();
  TextEditingController _villeTextController = TextEditingController();
  TextEditingController _adressTextController = TextEditingController();
  TextEditingController _aboutTextController = TextEditingController();

  TextEditingController _taxesTextController = TextEditingController();
  TextEditingController _qttTextController = TextEditingController();
  TextEditingController _minStockTextController = TextEditingController();
  TextEditingController _localisationTextController = TextEditingController();



  String  email='';
  String  about='';
  bool status = false;
  String  image='';
  // late List<Object> arr=[];

  late List<Object> arrInitiale=[];
  Future getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('infoEntrp')
        .doc(widget.docId)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        // arrInitiale =snapshot.data()!["Taxes"];
        setState(() {
          arrInitiale =snapshot.data()!["Taxes"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }




  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) => Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('infoEntrp').doc(widget.docId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // name=snapshot.data!["désignation"];
                image=snapshot.data!["imagePath"];
                // email=snapshot.data!["email"];
                // about=snapshot.data!["à_propos"];
                // arrInitiale=snapshot.data!["Taxes"];




                _desigTextController.text=snapshot.data!["désignation"];
                _phoneTextController.text=snapshot.data!["tel"];
                _faxTextController.text=snapshot.data!["fax"];
                _emailTextController.text=snapshot.data!["email"];
                _ribTextController.text=snapshot.data!["infoBc"];
                _villeTextController.text=snapshot.data!["id_ville"];
                _adressTextController.text=snapshot.data!["adresse"];
                _aboutTextController.text=snapshot.data!["à_propos"];
                _qttTextController.text=snapshot.data!["maxqttArticles"];
                _minStockTextController.text=snapshot.data!["qttMinStock"];
                _localisationTextController.text=snapshot.data!["localisation"];




                return Column(
                  children: [


                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: PrimaryText(
                        text: 'Parametres du compte',
                        size: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.them,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      physics: BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 15),
                        // TextFieldWidget(
                        //   label: 'Quantité maximale des articles',
                        //   controller: _qttTextController,
                        //   onChanged: (email) {},
                        // ),
                        //
                        // const SizedBox(height: 34),
                        TextFieldWidget(
                          label: 'Minimum du Stock',
                          controller: _minStockTextController,
                          onChanged: (email) {},
                        ),

                        const SizedBox(height: 34),

                        Stack(
                          children: [
                            TextFieldWidget(
                              label: 'Taxes',
                              controller: _taxesTextController,
                              onChanged: (email) {},
                            ),
                            Positioned(
                              bottom: 5,
                              right: 4,
                              child:   IconButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  iconSize: 20,
                                  icon: Icon(Icons.add, color: AppColors.them),
                                  onPressed: () {
                                    setState(() {
                                      arrInitiale.add(_taxesTextController.text);
                                    });
                                    // arrInitiale.add(_taxesTextController.text);
                                    // firebaseFiretore
                                    //     .collection(
                                    //     "infoEntrp")
                                    //     .doc(widget.docId)
                                    //     .update({
                                    //   "Taxes":
                                    //   arr
                                    // });
                                    _taxesTextController.text="";
                                    // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
                                  }),
                            ),

                          ],
                        ),


                        // TextFieldWidget(
                        //   label: 'Taxes',
                        //   controller: _taxesTextController,
                        //   onChanged: (email) {},
                        // ),
                        // const SizedBox(height: 34),
                        //
                        // //padding selon le width du screen
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     left: deviceWidth(context) * 0.6,
                        //
                        //   ),
                        //   child: firebaseUIButton(
                        //       context, "AJOUTER", () {
                        //     arr.add(_taxesTextController.text);
                        //     firebaseFiretore
                        //         .collection(
                        //         "infoEntrp")
                        //         .doc(widget.docId)
                        //         .update({
                        //       "Taxes":
                        //       arr
                        //     });
                        //
                        //     // _desigFournTextController.text="";
                        //   }, AppColors.them, Colors.white),
                        // ),


                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Table(
                            border: TableBorder.all(color: Colors.black45),
                            children: [
                              const TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Center(
                                      child: PrimaryText(
                                        text: 'Action',
                                        size: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Center(
                                      child: PrimaryText(
                                        text: 'Valeur de taxe',
                                        size: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (var item in arrInitiale.reversed)
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: IconButton(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          iconSize: 20,
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              arrInitiale.remove(item);
                                              // firebaseFiretore
                                              //     .collection(
                                              //     "infoEntrp")
                                              //     .doc(widget.docId)
                                              //     .update({
                                              //   "Taxes":
                                              //   arr
                                              // });
                                            });

                                            // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
                                          }),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: PrimaryText(
                                          text: item.toString(),
                                          size: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                            ],
                          ),
                        ),



                      ],
                    ),
                    const SizedBox(height: 45),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: PrimaryText(
                            text: 'Informations Generales',
                            size: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.them,
                          ),
                        ),
                        FlutterSwitch(
                          activeText: 'Afficher',
                          inactiveText: 'Cacher',
                          activeColor: AppColors.them,
                          width: 100,
                          height: 30,
                          valueFontSize:14,
                          toggleSize: 20,
                          value: status,
                          borderRadius: 30.0,
                          padding: 0.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ],),
                    SizedBox(
                      width: 40,
                    ),
                    Visibility(
                      visible:status,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        physics: BouncingScrollPhysics(),
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ProfileWidget(
                              imagePath: image,
                              isEdit: true,
                              onClicked: () async {},
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Nom de la Société',
                            controller: _desigTextController,
                            onChanged: (name) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Email',
                            controller: _emailTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Téléphone',
                            controller: _phoneTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Fax',
                            controller: _faxTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'RIB',
                            controller: _ribTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Ville',
                            controller: _villeTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Adresse',
                            controller: _adressTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'Localisation',
                            controller: _localisationTextController,
                            onChanged: (email) {},
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            label: 'A propos',
                            controller: _aboutTextController,
                            maxLines: 5,
                            onChanged: (about) {},
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: firebaseUIButton(
                                context, "ANNULER", () {

                              Navigator.pop(context);

                            }, Colors.grey, Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: firebaseUIButton(
                                context, "ENREGISTRER", () {
                              // arr.add(_taxesTextController.text);
                              firebaseFiretore
                                  .collection(
                                  "infoEntrp")
                                  .doc(widget.docId)
                                  .update({
                                "Taxes":
                                arrInitiale,
                                "désignation":_desigTextController.text,
                                "tel":_phoneTextController.text,
                                "fax":_faxTextController.text,
                                "email":_emailTextController.text,
                                "infoBc":_ribTextController.text,
                                "id_ville":_villeTextController.text,
                                "adresse":_adressTextController.text,
                                "à_propos":_aboutTextController.text,
                                "maxqttArticles":_qttTextController.text,
                                "qttMinStock":_minStockTextController.text,
                                "imagePath":image,
                                "localisation":_localisationTextController.text,
                              });
                              Navigator.pop(context);

                            }, AppColors.them, Colors.white),
                          ),
                        ),

                        // firebaseUIButton(
                        //     context, "ENREGISTRER", () {
                        //   arr.add(_taxesTextController.text);
                        //   firebaseFiretore
                        //       .collection(
                        //       "infoEntrp")
                        //       .doc(widget.docId)
                        //       .update({
                        //     "Taxes":
                        //     arr
                        //   });
                        //
                        //   // _desigFournTextController.text="";
                        // }, AppColors.them, Colors.white),
                      ],
                    ),
                  ],
                );}
              return Loading();
            }
        ),
      ),

    ),
  );
}
