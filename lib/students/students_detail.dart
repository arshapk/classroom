import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class StudentDetails extends StatefulWidget {
  var id;
  StudentDetails({Key? key,this.id}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  var studentData;

  @override
  void initState() {
    super.initState();
    personalDetails();
    print(widget.id);

  }

  void personalDetails()async{
    Response response;
    response = await Dio().get(
      "https://nibrahim.pythonanywhere.com/students/${widget.id}?api_key=C09b3",);
    studentData=response.data;
    print(studentData);
    print(studentData["name"]);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body: SingleChildScrollView(
            child:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Student Details",
                      style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
                  ],),
                SizedBox(height: 40,),
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 20,),
                Text(studentData["name"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                SizedBox(height: 10,),
                Text("Age : ${studentData["age"]}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),),
                SizedBox(height: 20,),
                Text(studentData["email"],style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13),)

              ],),
          ),
        ));
  }
}

