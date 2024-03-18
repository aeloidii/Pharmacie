// import 'package:flutter/material.dart';
//
// class NumbersWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           buildButton(context, '4.8', 'Ranking'),
//           buildDivider(),
//           buildButton(context, '35', 'Following'),
//           buildDivider(),
//           buildButton(context, '50', 'Followers'),
//         ],
//       );
//   Widget buildDivider() => Container(
//         height: 24,
//         child: VerticalDivider(),
//       );
//
//   Widget buildButton(BuildContext context, String value, String text) =>
//       MaterialButton(
//         padding: EdgeInsets.symmetric(vertical: 4),
//         onPressed: () {},
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               value,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             SizedBox(height: 2),
//             Text(
//               text,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       );
// }



import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NumbersWidget extends StatefulWidget {
  String docId;
  bool employe=true;
  NumbersWidget({super.key, required this.docId, required this.employe});


  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  String tel='';
  String email='';
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: widget.employe ? FirebaseFirestore.instance.collection('employee').doc(widget.docId).snapshots(): FirebaseFirestore.instance.collection('infoEntrp').doc(widget.docId).snapshots(),
      builder: (context, snapshot) { if (snapshot.hasError) {
        return Text('Something went wrong');
      }
      // void testing() async{
      //   var col = FirebaseFirestore.instance.collectionGroup('last');
      //   var snapshottest = await col.get();
      //   for (var doc in snapshottest.docs) {
      //     print(doc.reference.parent.parent?.id); // Prints document1, document2
      //
      //     //I need the parent root(The parent of this parent)
      //
      //   }
      // }
      // print("************************************");
      // testing();
      //
      // print("************************************");


      if (snapshot.hasData) {
        tel=snapshot.data!["tel"];
        email=snapshot.data!["email"];

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, InkWell(
              child: SvgPicture.asset(
                'assets/mail.svg',
                color: AppColors.them,width: 40,height: 40,
              ),
              onTap: () {
                launch('mailto: $email');
              },
            ), 'Email'),
            buildDivider(),
            buildButton(context, InkWell(
              child: SvgPicture.asset(
                'assets/call.svg',
                color: AppColors.them,width: 40,height: 40,
              ),
              onTap: () {
                launch('tel: $tel');
              },
            ), 'Call'),
            buildDivider(),
            buildButton(context, InkWell(
              child: SvgPicture.asset(
                'assets/msg.svg',
                color: AppColors.them,width: 40,height: 40,
              ),
              onTap: () {
                launch('sms:$tel?body= Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eaque recusandae consectetur exercitationem voluptatibus et, ipsam quae voluptas molestiae repudiandae reprehenderit in voluptatum sunt sint, dolorem beatae id perspiciatis suscipit vel temporibus officia illum! Consequuntur numquam quod consequatur eos quasi nostrum et quae, sunt culpa amet ipsa vitae nulla, ex perspiciatis fugiat adipisci iste laborum possimus suscipit aliquam sint incidunt nam exercitationem asperiores! Quisquam a unde voluptatibus, minima temporibus, cum delectus dicta ullam officiis magnam modi ut earum, et placeat omnis? Hic dolor asperiores aut ut autem natus, reprehende');
              },
            ), 'Message'),
          ],
        );
      }

      return Loading();

      }
  );



  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, Widget value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            value,
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
            ),
          ],
        ),
      );
}
