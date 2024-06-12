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
    setState(() {
      studentData=response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body: SingleChildScrollView(
            child: studentData==null?  Center(child: CircularProgressIndicator()):Container(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("Student Details",
                        style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
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
                  Text(studentData["name"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                  const SizedBox(height: 10,),
                  Text("Age : ${studentData["age"]}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),),
                  const SizedBox(height: 20,),
                  Text(studentData["email"],style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13),)
                ],),
            ),
          ),
        ));
  }
}