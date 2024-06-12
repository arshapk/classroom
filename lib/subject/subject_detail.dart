import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class SubjectDetails extends StatefulWidget {
  var id;
  SubjectDetails({Key? key,this.id}) : super(key: key);
  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  var subjectData;

  @override
  void initState() {
    super.initState();
    subjectDetails();
  }

  void subjectDetails()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/subjects/${widget.id}?api_key=C09b3"),);
  setState(() {
    subjectData=jsonDecode(response.body);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body: SingleChildScrollView(
        child: subjectData==null?const Center(child: CircularProgressIndicator()): Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Subject Details",
                  style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),),)
              ],),
            const SizedBox(height: 40,),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
             child: Image.asset(
                "assets/user.jpg",
              ),
            ),
            const SizedBox(height: 20,),
            Text(subjectData["name"],style:const
            TextStyle(fontWeight: FontWeight.w500,fontSize: 22.47),),
            const SizedBox(height: 10,),
            Text(subjectData["teacher"],
              style:const TextStyle(fontWeight: FontWeight.w400,fontSize: 22.47),),
            const  SizedBox(height: 10,),
            Text("Credit : ${subjectData["credits"]}"
              ,style:const TextStyle(fontWeight: FontWeight.w200,fontSize: 17.18),)
          ],
        ),
      ),
    );
  }
}