
import 'package:adminsignin/Model/Models.dart';
import 'package:adminsignin/component/employeeProfile.dart';
import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/profile/page/profile_page.dart';
import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/reusable_widget/reusablewidget.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adminsignin/component/table.dart';

import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
class employees extends StatefulWidget {


  employees({super.key});

  @override
  State<employees> createState() => _employeesState();
}

class _employeesState extends State<employees> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<dynamic> villes=[];
  String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _telTextController = TextEditingController();
  TextEditingController _EntrpTextController = TextEditingController();
  TextEditingController _roleTextController = TextEditingController();
  TextEditingController _adresseTextController = TextEditingController();
  // TextEditingController dateinput = TextEditingController();

  late roleEmpModel dataville;
  List<roleEmpModel> feature = [];

late String id_entr="1";
late String addBy;
late String id_roleEmp;
 String id_ajoutPar=FirebaseAuth.instance.currentUser!.uid;
  String photo='';
  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  // Future getFeatureData()  async {
  //   List<roleEmpModel> newList = [];
  //   QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
  //       .collection("roleEmpls").get();
  //   featureSnapShot.docs.forEach(
  //         (element) {
  //       dataville = roleEmpModel(
  //           id: element["id_roleEmpls"],
  //           designation: element["désignation"]);
  //       newList.add(dataville);
  //     },
  //   );
  //
  //   feature=newList;
  //   feature.sort((a, b) {
  //     return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
  //   });
  //
  // }
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Future<void> deleteUser(String userId) async {
  //   try {
  //     // Récupération de l'utilisateur à partir de son UID
  //     User? user = await getUser(userId);
  //     if (user != null) {
  //       // Suppression de l'utilisateur de Firebase Authentication
  //       await user.delete();
  //       print("Utilisateur supprimé avec succès.");
  //     }
  //   } catch (error) {
  //     print("Erreur lors de la suppression de l'utilisateur : $error");
  //   }
  // }

  Future<User?> getUser(String userId) async {
    try {
      User? user = await auth.userChanges().firstWhere((firebaseUser) => firebaseUser?.uid == userId);
      return user;
    } catch (error) {
      print("Erreur lors de la récupération de l'utilisateur : $error");
      return null;
    }
  }





  Future getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection('employee').doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async{
      if(snapshot.exists){
        setState(() async {
          String idEntrp =snapshot.data()!["id_Etrp"];
          String ajtPar =snapshot.data()!["nom"];
          id_entr=idEntrp;
            await FirebaseFirestore.instance.collection('infoEntrp').doc(idEntrp).get().then((snapshot) async{
              if(snapshot.exists){
                setState((){
                _EntrpTextController.text =snapshot.data()!["désignation"];
                });
              }
            });

        });
      }
    });
  }


  @override
  void initState(){
    super.initState();
    // this.villes.add({"id":1,"label":"Casablanca"});
    // this.villes.add({"id":2,"label":"Safi"});
    // getFeatureData();
    getDataFromDatabase();
  }



  // Future<List<OrderModel>> getAllOrders() async =>
  //     firebaseFiretore.collection(collection).get().then((result) {
  //       List<OrderModel> orders = [];
  //       for (DocumentSnapshot order in result.docs) {
  //         orders.add(OrderModel.fromSnapshot(order));
  //       }
  //       return orders;
  //     });





  String path="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  late final image = NetworkImage(path);




  @override
  Widget build(BuildContext context) {
    // final ProductProvider villeProvider = Provider.of<ProductProvider>(context);
    // villeProvider.getFeatureData();
    // List<villeModel> listeVille= villeProvider.getFeatureList;






    // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now());
    // print( dateinput.text);

    print("*************************************************");
    print( _EntrpTextController.text);
    print("*************************************************");
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 109, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(

            onPressed: () {
              _drawerKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu, color: hexSrtingToColor('20B2AA'))),
        actions: [
          AppBarActionItems(),
        ],
      )
          : PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              SizedBox(
                width: 100,
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Utilisateurs','Ajout'),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'AJOUTER UN EMPLOYE',
                          size: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.them,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        (!Responsive.isDesktop(context))?
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const SizedBox(
                              //   height: 300,
                              // ),

                              //à remplacer par l'mage
                              Column(
                                children: [
                                  // const Padding(
                                  // padding: EdgeInsets.all(8.0),
                                  // child: PrimaryText(
                                  // color: AppColors.them,
                                  // text: "Ajouter une image",
                                  // size: 14,
                                  // fontWeight: FontWeight.w800),
                                  // ),

                                  Padding(
                                    padding: const EdgeInsets.only(top:30, bottom: 20),
                                    child: Center(
                                      child: Container(
                                        width: 80,
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Ink.image(
                                              image: image,
                                              fit: BoxFit.cover,
                                              width: 80,
                                              height: 80,
                                              child: InkWell(onTap: (){}),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // const SizedBox(
                              //   height: 20,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width,
                                      child: reusableTextFieldAdd("Enter UserName", Icons.person_outline, false,
                                          _userNameTextController, true),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 8),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //
                              //       Container(
                              //         width: MediaQuery. of(context). size. width,
                              //         // child: TextField(
                              //         //   controller: dateinput, //editing controller of this TextField
                              //         //   decoration:  InputDecoration(
                              //         //       icon: const Icon(Icons.calendar_today), //icon of text field
                              //         //       labelText: "${DateTime.now()}" //label text of field
                              //         //   ),
                              //         //   readOnly: true,  //set it true, so that user will not able to edit text
                              //         //   onTap: () async {
                              //         //     DateTime? pickedDate = await showDatePicker(
                              //         //         context: context, initialDate: DateTime.now(),
                              //         //         firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              //         //         lastDate: DateTime(2101)
                              //         //     );
                              //         //
                              //         //     if(pickedDate != null ){
                              //         //       print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              //         //       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              //         //       print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //         //       //you can implement different kind of Date Format here according to your requirement
                              //         //
                              //         //       setState(() {
                              //         //         dateinput.text = formattedDate; //set output date to TextField value.
                              //         //       });
                              //         //     }else{
                              //         //       print("Date is not selected");
                              //         //     }
                              //         //   },
                              //         // ),
                              //         child: reusableTextFieldDate(DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()), Icons.calendar_today, false,dateinput,
                              //                 () async {
                              //               // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                              //               DateTime? pickedDate = await showDatePicker(
                              //                   context: context, initialDate: DateTime.now(),
                              //                   firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              //                   lastDate: DateTime(2101)
                              //               );
                              //
                              //               TimeOfDay? pickedTime =  await showTimePicker(
                              //                 initialTime: TimeOfDay.now(),
                              //                 context: context, //context of current state
                              //               );
                              //
                              //               if(pickedDate != null && pickedTime != null ){
                              //                 print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              //                 String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              //                 print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //                 //you can implement different kind of Date Format here according to your requirement
                              //
                              //                 DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                              //                 //converting to DateTime so that we can further format on different pattern.
                              //                 print(parsedTime); //output 1970-01-01 22:53:00.000
                              //                 String formattedTime = DateFormat('HH:mm').format(parsedTime);
                              //
                              //
                              //
                              //                 setState(() {
                              //                   dateinput.text = formattedDate+"  "+formattedTime; //set output date to TextField value.
                              //                   });
                              //               }else{
                              //                 ScaffoldMessenger.of(context).showSnackBar(
                              //                     SnackBar(content: Text("Selectionner une date!"),backgroundColor: Colors.red,showCloseIcon: true,)
                              //                 );
                              //                 print("Date is not selected ");
                              //               }}) ,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const Padding(
                                    //   padding: EdgeInsets.only(top:8.0, bottom: 4.0),
                                    //   child: PrimaryText(
                                    //       color: AppColors.them,
                                    //       text: "Nom du catégorie",
                                    //       size: 14,
                                    //       fontWeight: FontWeight.w800),
                                    // ),
                                    Container(
                                      width: MediaQuery. of(context). size. width,
                                      child: reusableTextFieldAdd("Email", Icons.email_outlined, false,
                                          _emailTextController,true),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width,
                                      child: reusableTextFieldAdd("Mot de passe", Icons.lock_outlined, false,
                                          _passwordTextController,true),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width,
                                      child: reusableTextFieldAdd("Entreprise", Icons.person_outline, false,
                                          _EntrpTextController, false),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Stack(
                                      children: [

                                        Container(
                                          width: MediaQuery. of(context). size. width,
                                          child: reusableTextFieldAdd("Role", Icons.person_outline, false,
                                              _roleTextController,false),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 4,
                                          child:  StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("roleEmpls").snapshots(),
                                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (snapshot.hasError) {
                                                  return const Text('Something went wrong');
                                                }
                                                if (snapshot.hasData){
                                                  List<roleEmpModel> newList = [];

                                                  var docs=snapshot.data?.docs;
                                                  docs?.forEach(
                                                          (element){
                                                        var routeArgs = element.data() as Map;

                                                        dataville = roleEmpModel(
                                                            id: routeArgs["id_roleEmpls"],
                                                            designation: routeArgs["désignation"]);
                                                        newList.add(dataville);

                                                      });




                                                  feature=newList;
                                                  feature.sort((a, b) {
                                                    return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
                                                  });



                                                  // return Loading();
                                                  return PopupMenuButton<roleEmpModel>(
                                                    offset: Offset(20, 0),
                                                    elevation: 8.0,
                                                    shape: const TooltipShape(),
                                                    color: hexSrtingToColor("AFD6D0"),
                                                    icon: const Icon(Icons.arrow_right_outlined, color: Colors.white),
                                                    onSelected: (choice){
                                                      print(choice);
                                                      setState((){
                                                        id_roleEmp=choice.ID;
                                                      });
                                                      _roleTextController.text=choice.DESIGNATION;
                                                    },
                                                    itemBuilder: (BuildContext context) {
                                                      return feature.map((roleEmpModel choice) {
                                                        return PopupMenuItem<roleEmpModel>(

                                                          value: choice,
                                                          child:
                                                          Row(

                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets.only(left:8.0,right: 10.0),
                                                                  // child: SvgPicture.asset(
                                                                  //   'assets/pie-chart.svg',
                                                                  //   color: AppColors.white,width: 20,height: 20,
                                                                  // ),
                                                                  child: Icon(Icons.circle_rounded, color: Colors.white,size: 10,),

                                                                ),
                                                                Text(choice.DESIGNATION,style: TextStyle(
                                                                  color: Colors.white,
                                                                  // fontWeight: FontWeight.w400,
                                                                  // fontFamily: 'Poppins',
                                                                  fontSize: 14,

                                                                ),),

                                                              ]
                                                          ),);

                                                      }).toList();
                                                    },
                                                  );

                                                }
                                                return Loading();

                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width,
                                      child: reusableTextFieldAdd("Télephone", Icons.phone_android_outlined, false,
                                          _telTextController, true),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: MediaQuery. of(context). size. width,
                                    child: reusableTextFieldAdd("Adresse", Icons.map_outlined, false,
                                        _adresseTextController, true),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: MediaQuery. of(context). size. width,
                                    height: 80,
                                    child: firebaseUIButton(context, "AJOUTER", () {
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password: _passwordTextController.text)
                                          .then((value) {
                                        //firestoreStart
                                        FirebaseAuth.instance.signOut();
                                        firebaseFiretore.collection("employee").doc(value.user?.uid).set({
                                          "nom": _userNameTextController.text,
                                          "id_employe": value.user?.uid,
                                          "email": _emailTextController.text,
                                          "Password": _passwordTextController.text,
                                          "id_Etrp": id_entr,
                                          "id_roleEmpls": id_roleEmp,
                                          "tel": _telTextController.text,
                                          "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                          "adresse": _adresseTextController.text,
                                          "Ajouté par ": id_ajoutPar,
                                          "ImagePath": "",
                                          "à_propos": "",
                                          "availability": 'Disponible',
                                          "state": 'activated',

                                        });
                                        // if(id_roleEmp=="02S3mJ118bXc5m3TY4ox") {
                                        //   print("Ajout d'un Livreur");
                                        //   firebaseFiretore
                                        //       .collection("employee")
                                        //       .doc(value.user?.uid)
                                        //       .update({
                                        //     "availability": '',
                                        //   });
                                        // }
                                        _adresseTextController.text="";
                                        _roleTextController.text="";
                                        _telTextController.text="";
                                        _userNameTextController.text="";
                                        _emailTextController.text="";
                                        _passwordTextController.text="";

                                        //old config
                                        /**
                                            rules_version = '2';
                                            service cloud.firestore {
                                            match /databases/{database}/documents {
                                            match /{document=**} {
                                            allow read, write: if false;
                                            }
                                            }
                                            }
                                         */
                                        //firestoreEnd
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Ajouté avec succès"),backgroundColor: AppColors.them,showCloseIcon: true,)
                                        );
                                        print("Created New Account");
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) => HomeScreen()));
                                      }).onError((error, stackTrace) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(error.toString().substring(30, )),backgroundColor: Colors.red,showCloseIcon: true,)
                                        );
                                        print("Error❗✅ ${error.toString()}");
                                      });
                                    }, AppColors.them,Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              PrimaryText(
                                text:
                                'LISTE DES EMPLOYES DE LA ${_EntrpTextController.text.toUpperCase()}',
                                size: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.them,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('employee').orderBy('dateAjout', descending: true).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }

                                          if (snapshot.hasData) {

                                            List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                              var routeArgs = doc.data() as Map;

                                              return routeArgs['id_Etrp'] == id_entr && routeArgs['state'] == 'activated'; // skip rows that don't match the condition
                                            }).map((doc) {
                                              var routeArgs = doc.data() as Map;
                                              var photo= routeArgs['ImagePath'];
                                              String IDaddBy;
                                              IDaddBy= routeArgs['Ajouté par '];
                                              return DataRow(
                                                cells: [


                                                  DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      IconButton(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                          iconSize: 20,
                                                          icon: Icon(Icons.edit, color: AppColors.them),
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => employees(),
                                                              ),
                                                            );
                                                          }),
                                                      IconButton(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                          iconSize: 20,
                                                          icon: Icon(Icons.delete, color: Colors.red),
                                                          onPressed: () {
                                                            // deleteUser(doc.id);
                                                            // FirebaseFirestore.instance.collection('employee').doc(doc.id).delete();
                                                            FirebaseFirestore.instance.collection('employee').doc(doc.id).update({
                                                              "state": "deactivated",
                                                            });

                                                          }),
                                                      // Icon(Icons.edit, color: AppColors.them),
                                                      // Icon(Icons.delete, color: AppColors.them),

                                                    ],


                                                  ),),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('roleEmpls').doc(routeArgs['id_roleEmpls']).snapshots(),
                                                      builder: (context, snapshot) { if (snapshot.hasError) {
                                                        return Text('Something went wrong');
                                                      }
                                                      if (snapshot.hasData) {
                                                        String role;
                                                        role=snapshot.data!["désignation"];

                                                        return InkWell(
                                                          child: CircleAvatar(
                                                            radius: 17,
                                                            backgroundImage: NetworkImage(
                                                                image=='' ?defaultPath : photo
                                                              // image==null ?defaultPath : image!
                                                              // defaultPath,

                                                            ),


                                                          ),
                                                          onTap: () {
                                                            print("moving to EmployeesProfile");
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => EmployeesProfile(docId: doc.id, role: role),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }

                                                      return Loading();

                                                      }
                                                  ),),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('roleEmpls').doc(routeArgs['id_roleEmpls']).snapshots(),
                                                      builder: (context, snapshot) { if (snapshot.hasError) {
                                                        return Text('Something went wrong');
                                                      }
                                                      if (snapshot.hasData) {
                                                        String role;
                                                        role=snapshot.data!["désignation"];

                                                        return Text(role ?? 'default value');
                                                      }

                                                      return Loading();

                                                      }
                                                  ),),
                                                  DataCell(Text(routeArgs['nom'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['email'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['tel'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('employee').doc(IDaddBy).snapshots(),
                                                      builder: (context, snapshot) { if (snapshot.hasError) {
                                                        return Text('Something went wrong');
                                                      }
                                                      if (snapshot.hasData) {
                                                        String addBy;
                                                        addBy=snapshot.data!["nom"];

                                                        return Text(addBy ?? 'default value');
                                                      }

                                                      return Loading();

                                                      }
                                                  ),),
                                                  DataCell(Text(routeArgs['dateAjout'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['à_propos'] ?? 'default value')),
                                                  // add more cells as needed
                                                ],
                                              );
                                            }).toList();

                                            //Phone

                                            return PaginatedDataTable(
                                              columns: const [

                                                DataColumn(label: Padding(
                                                  padding: EdgeInsets.only(left: 30),
                                                  child: Center(child: Text("Action")),
                                                )),
                                                DataColumn(label: Center(child: Text("Photo"))),
                                                DataColumn(label: Center(child: Text("Role"))),
                                                DataColumn(label: Center(child: Text("Nom"))),
                                                DataColumn(label: Center(child: Text("Email"))),
                                                DataColumn(label: Center(child: Text("Tel"))),
                                                DataColumn(label: Center(child: Text("Adresse"))),
                                             DataColumn(label: Center(child: Text("Ajouté par"))),
                                                DataColumn(label: Center(child: Text("Date d'ajout"))),
                                                DataColumn(label: Center(child: Text("A propos"))),
                                              ],
                                              source: MyData(rows!),
                                              // header:  PrimaryText(
                                              //   text: 'LISTE DES CATEGORIES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,)
                                              horizontalMargin: 2,
                                              rowsPerPage: 8,
                                            );
                                          }
                                          return Text("ERROR");


                                        }
                                    ),
                                  )
                                ],
                              )

                            ]):
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [

                                  //à remplacer par l'mage
                                  Column(
                                    children: [
                                      // const Padding(
                                      // padding: EdgeInsets.all(8.0),
                                      // child: PrimaryText(
                                      // color: AppColors.them,
                                      // text: "Ajouter une image",
                                      // size: 14,
                                      // fontWeight: FontWeight.w800),
                                      // ),
                                      Container(
                                        width: MediaQuery. of(context). size. width/4,
                                        // height: MediaQuery. of(context). size. width/12,
                                        child: Center(
                                          // width: MediaQuery. of(context). size. width/12,
                                          // height: MediaQuery. of(context). size. width/12,
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: image,
                                                fit: BoxFit.cover,
                                                width: MediaQuery. of(context). size. width/12,
                                                height: MediaQuery. of(context). size. width/12,
                                                child: InkWell(onTap: (){}),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16,right: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Container(
                                          width: MediaQuery. of(context). size. width/4,
                                          child: reusableTextFieldAdd("Enter UserName", Icons.person_outline, false,
                                              _userNameTextController, true),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        width: MediaQuery. of(context). size. width/4,
                                        child: reusableTextFieldAdd("Télephone", Icons.phone_android_outlined, false,
                                            _telTextController, true),
                                      ),
                                    ],
                                  ),

                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //
                                  //     Container(
                                  //       width: MediaQuery. of(context). size. width/4,
                                  //       child: reusableTextFieldDate(DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()), Icons.calendar_today, false,dateinput,
                                  //               () async {
                                  //             // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                                  //             DateTime? pickedDate = await showDatePicker(
                                  //                 context: context, initialDate: DateTime.now(),
                                  //                 firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                  //                 lastDate: DateTime(2101)
                                  //             );
                                  //
                                  //             TimeOfDay? pickedTime =  await showTimePicker(
                                  //               initialTime: TimeOfDay.now(),
                                  //               context: context, //context of current state
                                  //             );
                                  //
                                  //             if(pickedDate != null && pickedTime != null ){
                                  //               print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                  //               String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  //               print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //               //you can implement different kind of Date Format here according to your requirement
                                  //
                                  //               DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                  //               //converting to DateTime so that we can further format on different pattern.
                                  //               print(parsedTime); //output 1970-01-01 22:53:00.000
                                  //               String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                  //
                                  //
                                  //
                                  //               setState(() {
                                  //                 dateinput.text = formattedDate+"  "+formattedTime; //set output date to TextField value.
                                  //               });
                                  //             }else{
                                  //               ScaffoldMessenger.of(context).showSnackBar(
                                  //                   SnackBar(content: Text("Selectionner une date!"),backgroundColor: Colors.red,showCloseIcon: true,)
                                  //               );
                                  //               print("Date is not selected");
                                  //             }}) ,
                                  //     ),
                                  //   ],
                                  // ),

                                  // const SizedBox(
                                  //   height: 20,
                                  // ),

                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [


                                //à remplacer par l'mage


                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     // Container(
                                //     //   width: MediaQuery. of(context). size. width/4,
                                //     //   child:   new Theme(
                                //     //     data: Theme.of(context).copyWith(
                                //     //       canvasColor: Colors.blue.shade200,
                                //     //     ), child: FormHelper.dropDownWidgetWithLabel(
                                //     //       context,
                                //     //       "",
                                //     //       "Selectionner la ville",
                                //     //       this.villeId,
                                //     //       this.villes,
                                //     //
                                //     //           (onChangedVal) {
                                //     //         this.villeId = onChangedVal;
                                //     //         print("Ville selectionnée: $onChangedVal");
                                //     //       },
                                //     //           (onValidateVal) {
                                //     //         if (onValidateVal == null) {
                                //     //           return 'Selectionner une ville';
                                //     //         }
                                //     //
                                //     //         return null;
                                //     //       },
                                //     //       prefixIcon: Icon(Icons.person_outline,  color: Colors.white,),
                                //     //       borderFocusColor: Theme.of(context).primaryColor,
                                //     //       borderWidth: 0,
                                //     //       borderRadius: 30,
                                //     //       optionValue: "id",
                                //     //       optionLabel: "label"
                                //     //   ),)
                                //     // ),
                                //   ],
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width/4,
                                      child: reusableTextFieldAdd("Email", Icons.email_outlined, false,
                                          _emailTextController,true),
                                    ),
                                  ],
                                ),




                                Padding(
                                  padding: const EdgeInsets.only(left: 16,right: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        width: MediaQuery. of(context). size. width/4,
                                        child: reusableTextFieldAdd("Mot de passe", Icons.lock_outlined, false,
                                            _passwordTextController,true),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width/4,
                                      child: reusableTextFieldAdd("Entreprise", Icons.person_outline, false,
                                          _EntrpTextController, false),
                                    ),
                                  ],
                                ),



                                const SizedBox(
                                  height: 100,
                                ),
                                // firebaseUIButton(context, "Sign Up", () {
                                //   FirebaseAuth.instance
                                //       .createUserWithEmailAndPassword(
                                //       email: _emailTextController.text,
                                //       password: _passwordTextController.text)
                                //       .then((value) {
                                //     //firestoreStart
                                //     firebaseFiretore.collection("admins").doc(value.user?.uid).set({
                                //       "FullName": _userNameTextController.text,
                                //       "id": value.user?.uid,
                                //       "Email": _emailTextController.text,
                                //       "Password": _passwordTextController.text,
                                //     });
                                //     //old config
                                //     /**
                                //         rules_version = '2';
                                //         service cloud.firestore {
                                //         match /databases/{database}/documents {
                                //         match /{document=**} {
                                //         allow read, write: if false;
                                //         }
                                //         }
                                //         }
                                //      */
                                //     //firestoreEnd
                                //
                                //     print("Created New Account");
                                //     Navigator.push(context,
                                //         MaterialPageRoute(builder: (context) => HomeScreen()));
                                //   }).onError((error, stackTrace) {
                                //     print("Error❗✅ ${error.toString()}");
                                //   });
                                // })
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children:  [
                            //     const SizedBox(
                            //       height: 300,
                            //     ),
                            //
                            //     //à remplacer par l'mage
                            //
                            //
                            //     // const SizedBox(
                            //     //   height: 20,
                            //     // ),
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         const Padding(
                            //           padding: EdgeInsets.only(top:8.0, bottom: 4.0),
                            //           child: PrimaryText(
                            //               color: AppColors.them,
                            //               text: "Nom du catégorie",
                            //               size: 14,
                            //               fontWeight: FontWeight.w800),
                            //         ),
                            //         Container(
                            //           width: MediaQuery. of(context). size. width/4,
                            //           child: reusableTextFieldAdd("Enter UserName", Icons.person_outline, false,
                            //               _userNameTextController),
                            //         ),
                            //       ],
                            //     ),
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         const Padding(
                            //           padding: EdgeInsets.only(top:8.0, bottom: 4.0),
                            //           child: PrimaryText(
                            //               color: AppColors.them,
                            //               text: "Nom du catégorie",
                            //               size: 14,
                            //               fontWeight: FontWeight.w800),
                            //         ),
                            //         Container(
                            //           width: MediaQuery. of(context). size. width/4,
                            //           child: reusableTextFieldAdd("Enter UserName", Icons.person_outline, false,
                            //               _userNameTextController),
                            //         ),
                            //       ],
                            //     ),
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         const Padding(
                            //           padding: EdgeInsets.only(top:8.0, bottom: 4.0),
                            //           child: PrimaryText(
                            //               color: AppColors.them,
                            //               text: "Nom du catégorie",
                            //               size: 14,
                            //               fontWeight: FontWeight.w800),
                            //         ),
                            //         Container(
                            //           width: MediaQuery. of(context). size. width/4,
                            //           child: reusableTextFieldAdd("Enter UserName", Icons.person_outline, false,
                            //               _userNameTextController),
                            //         ),
                            //       ],
                            //     ),
                            //
                            //
                            //     const SizedBox(
                            //       height: 20,
                            //     ),
                            //     // firebaseUIButton(context, "Sign Up", () {
                            //     //   FirebaseAuth.instance
                            //     //       .createUserWithEmailAndPassword(
                            //     //       email: _emailTextController.text,
                            //     //       password: _passwordTextController.text)
                            //     //       .then((value) {
                            //     //     //firestoreStart
                            //     //     firebaseFiretore.collection("admins").doc(value.user?.uid).set({
                            //     //       "FullName": _userNameTextController.text,
                            //     //       "id": value.user?.uid,
                            //     //       "Email": _emailTextController.text,
                            //     //       "Password": _passwordTextController.text,
                            //     //     });
                            //     //     //old config
                            //     //     /**
                            //     //         rules_version = '2';
                            //     //         service cloud.firestore {
                            //     //         match /databases/{database}/documents {
                            //     //         match /{document=**} {
                            //     //         allow read, write: if false;
                            //     //         }
                            //     //         }
                            //     //         }
                            //     //      */
                            //     //     //firestoreEnd
                            //     //
                            //     //     print("Created New Account");
                            //     //     Navigator.push(context,
                            //     //         MaterialPageRoute(builder: (context) => HomeScreen()));
                            //     //   }).onError((error, stackTrace) {
                            //     //     print("Error❗✅ ${error.toString()}");
                            //     //   });
                            //     // })
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [



                                Center(
                                  child: Stack(
                                    children: [

                                      Container(
                                        width: MediaQuery. of(context). size. width/4,
                                        child: reusableTextFieldAdd("Role", Icons.person_outline, false,
                                            _roleTextController,false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child:  StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("roleEmpls").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){
                                                List<roleEmpModel> newList = [];

                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      dataville = roleEmpModel(
                                                          id: routeArgs["id_roleEmpls"],
                                                          designation: routeArgs["désignation"]);
                                                      newList.add(dataville);

                                                    });




                                                feature=newList;
                                                feature.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
                                                });



                                                // return Loading();
                                                return PopupMenuButton<roleEmpModel>(
                                                  offset: Offset(20, 0),
                                                  elevation: 8.0,
                                                  shape: const TooltipShape(),
                                                  color: hexSrtingToColor("AFD6D0"),
                                                  icon: const Icon(Icons.arrow_right_outlined, color: Colors.white),
                                                  onSelected: (choice){
                                                    print(choice);
                                                    setState((){
                                                      id_roleEmp=choice.ID;
                                                    });
                                                    _roleTextController.text=choice.DESIGNATION;
                                                  },
                                                  itemBuilder: (BuildContext context) {
                                                    return feature.map((roleEmpModel choice) {
                                                      return PopupMenuItem<roleEmpModel>(

                                                        value: choice,
                                                        child:
                                                        Row(

                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets.only(left:8.0,right: 10.0),
                                                                // child: SvgPicture.asset(
                                                                //   'assets/pie-chart.svg',
                                                                //   color: AppColors.white,width: 20,height: 20,
                                                                // ),
                                                                child: Icon(Icons.circle_rounded, color: Colors.white,size: 10,),

                                                              ),
                                                              Text(choice.DESIGNATION,style: TextStyle(
                                                                color: Colors.white,
                                                                // fontWeight: FontWeight.w400,
                                                                // fontFamily: 'Poppins',
                                                                fontSize: 14,

                                                              ),),

                                                            ]
                                                        ),);

                                                    }).toList();
                                                  },
                                                );

                                              }
                                              return Loading();

                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16,right: 16),
                                  child: Container(
                                    width: MediaQuery. of(context). size. width/4,
                                    child: reusableTextFieldAdd("Adresse", Icons.map_outlined, false,
                                        _adresseTextController, true),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: MediaQuery. of(context). size. width/4,
                                      child:Text(""),
                                    ),
                                  ],
                                ),



                                const SizedBox(
                                  height: 20,
                                ),
                                // firebaseUIButton(context, "Sign Up", () {
                                //   FirebaseAuth.instance
                                //       .createUserWithEmailAndPassword(
                                //       email: _emailTextController.text,
                                //       password: _passwordTextController.text)
                                //       .then((value) {
                                //     //firestoreStart
                                //     firebaseFiretore.collection("admins").doc(value.user?.uid).set({
                                //       "FullName": _userNameTextController.text,
                                //       "id": value.user?.uid,
                                //       "Email": _emailTextController.text,
                                //       "Password": _passwordTextController.text,
                                //     });
                                //     //old config
                                //     /**
                                //         rules_version = '2';
                                //         service cloud.firestore {
                                //         match /databases/{database}/documents {
                                //         match /{document=**} {
                                //         allow read, write: if false;
                                //         }
                                //         }
                                //         }
                                //      */
                                //     //firestoreEnd
                                //
                                //     print("Created New Account");
                                //     Navigator.push(context,
                                //         MaterialPageRoute(builder: (context) => HomeScreen()));
                                //   }).onError((error, stackTrace) {
                                //     print("Error❗✅ ${error.toString()}");
                                //   });
                                // })
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:75, top: 20),
                                  child: Container(
                                    width: MediaQuery. of(context). size. width/8,
                                    height: 80,
                                    child: firebaseUIButton(context, "AJOUTER", () {
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password: _passwordTextController.text)
                                          .then((value) {
                                        FirebaseAuth.instance.signOut();
                                        //firestoreStart
                                        firebaseFiretore.collection("employee").doc(value.user?.uid).set({
                                          "nom": _userNameTextController.text,
                                          "id_employe": value.user?.uid,
                                          "email": _emailTextController.text,

                                          "Password": _passwordTextController.text,
                                          "id_Etrp": id_entr,
                                          "id_roleEmpls": id_roleEmp,

                                          "tel": _telTextController.text,
                                          "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                          "adresse": _adresseTextController.text,

                                          "Ajouté par ": id_ajoutPar,
                                          "ImagePath": "",
                                          "à_propos": "",

                                          "availability": 'Disponible',
                                          "state": 'activated',
                                        });

                                        // if(id_roleEmp=="02S3mJ118bXc5m3TY4ox") {
                                        //   print("Ajout d'un Livreur");
                                        //         firebaseFiretore
                                        //             .collection("employee")
                                        //             .doc(value.user?.uid)
                                        //             .update({
                                        //           "availability": '',
                                        //         });
                                        //       }

                                              _adresseTextController.text="";
                                        _roleTextController.text="";
                                        _telTextController.text="";
                                        _userNameTextController.text="";
                                        _emailTextController.text="";
                                        _passwordTextController.text="";
                                        //old config
                                        /**
                                            rules_version = '2';
                                            service cloud.firestore {
                                            match /databases/{database}/documents {
                                            match /{document=**} {
                                            allow read, write: if false;
                                            }
                                            }
                                            }
                                         */
                                        //firestoreEnd
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Ajouté avec succès"),backgroundColor: AppColors.them,showCloseIcon: true,)
                                        );
                                        print("Created New Account");
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) => HomeScreen()));
                                      }).onError((error, stackTrace) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(error.toString().substring(30, )),backgroundColor: Colors.red,showCloseIcon: true,)
                                        );
                                        print("Error❗✅ ${error.toString()}");
                                      });
                                    }, AppColors.them,Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            PrimaryText(
                              text:
                              'LISTE DES EMPLOYES DE LA ${_EntrpTextController.text.toUpperCase()}',
                              size: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.them,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('employee').orderBy('dateAjout', descending: true).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        }

                                        if (snapshot.hasData) {

                                          List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                            var routeArgs = doc.data() as Map;

                                            return routeArgs['id_Etrp'] == id_entr && routeArgs['state'] == 'activated'; // skip rows that don't match the condition
// skip rows that don't match the condition
                                          }).map((doc) {
                                            var routeArgs = doc.data() as Map;
                                            var photo= routeArgs['ImagePath'];
                                            print("*************************");
                                            // print("pppp ${routeArgs['Ajouté par ']} ");
                                            // print("dddd ${routeArgs['id_roleEmpls']} ");
                                            String IDaddBy;
                                            IDaddBy=routeArgs['Ajouté par '];
                                            print("*************************");
                                            return DataRow(
                                              cells: [


                                                DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        iconSize: 20,
                                                        icon: Icon(Icons.edit, color: AppColors.them),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => employees(),
                                                            ),
                                                          );
                                                        }),
                                                    IconButton(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        iconSize: 20,
                                                        icon: Icon(Icons.delete, color: Colors.red),
                                                        onPressed: () {
                                                          // deleteUser(doc.id);
                                                          // FirebaseFirestore.instance.collection('employee').doc(doc.id).delete();
                                                          FirebaseFirestore.instance.collection('employee').doc(doc.id).update({
                                                            "state": "deactivated",
                                                          });

                                                        }),
                                                    // Icon(Icons.edit, color: AppColors.them),
                                                    // Icon(Icons.delete, color: AppColors.them),

                                                  ],


                                                ),),
                                                DataCell(StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection('roleEmpls').doc(routeArgs['id_roleEmpls']).snapshots(),
                                                    builder: (context, snapshot) { if (snapshot.hasError) {
                                                      return Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData) {
                                                      String role;
                                                      role=snapshot.data!["désignation"];

                                                      return InkWell(
                                                        child: CircleAvatar(
                                                          radius: 17,
                                                          backgroundImage: NetworkImage(
                                                              image=='' ?defaultPath : photo
                                                            // image==null ?defaultPath : image!
                                                            // defaultPath,

                                                          ),


                                                        ),
                                                        onTap: () {
                                                          print("moving to EmployeesProfile");
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => EmployeesProfile(docId: doc.id, role: role),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    return Loading();

                                                    }
                                                ),),
                                                DataCell(StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection('roleEmpls').doc(routeArgs['id_roleEmpls']).snapshots(),
                                                    builder: (context, snapshot) { if (snapshot.hasError) {
                                                      return Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData) {
                                                      String role;
                                                      role=snapshot.data!["désignation"];

                                                      return Text(role ?? 'default value');
                                                    }

                                                    return Loading();

                                                    }
                                                ),),
                                                DataCell(Text(routeArgs['nom'] ?? 'default value')),
                                                DataCell(Text(routeArgs['email'] ?? 'default value')),
                                                DataCell(Text(routeArgs['tel'] ?? 'default value')),
                                                DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                                DataCell(StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection('employee').doc(IDaddBy).snapshots(),
                                                    builder: (context, snapshot) { if (snapshot.hasError) {
                                                      return Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData) {
                                                      String addBy;
                                                      addBy=snapshot.data!["nom"];

                                                      return Text(addBy ?? 'default value');
                                                    }

                                                    return Loading();

                                                    }
                                                ),),
                                                DataCell(Text(routeArgs['dateAjout'] ?? 'default value')),
                                                DataCell(Text(routeArgs['à_propos'] ?? 'default value')),
                                                // add more cells as needed
                                              ],
                                            );
                                          }).toList();

                                          //web
                                          return PaginatedDataTable(
                                            columns: const [

                                              DataColumn(label: Padding(
                                                padding: EdgeInsets.only(left: 30),
                                                child: Center(child: Text("Action")),
                                              )),
                                              DataColumn(label: Center(child: Text("Photo"))),
                                              DataColumn(label: Center(child: Text("Role"))),
                                              DataColumn(label: Center(child: Text("Nom"))),
                                              DataColumn(label: Center(child: Text("Email"))),
                                              DataColumn(label: Center(child: Text("Tel"))),
                                              DataColumn(label: Center(child: Text("Adresse"))),
                                              DataColumn(label: Center(child: Text("Ajouté par"))),
                                              DataColumn(label: Center(child: Text("Date d'ajout"))),
                                              DataColumn(label: Center(child: Text("A propos"))),
                                            ],
                                            source: MyData(rows!),
                                            // header:  PrimaryText(
                                            //   text: 'LISTE DES CATEGORIES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,)
                                            horizontalMargin: 2,
                                            rowsPerPage: 8,
                                          );
                                        }
                                        return Text("ERROR");


                                      }
                                  ),
                                )
                              ],
                            )
                          ],
                        ),



                      ],
                    ),
                  ),
                )),

          ],
        ),
      ),
    );
  }
}







