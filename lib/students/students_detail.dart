import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
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
  }

  void personalDetails()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/students/${widget.id}?api_key=C09b3"),);
    setState(() {
      studentData=jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body: SingleChildScrollView(
        child: studentData==null? const Center(child: CircularProgressIndicator()):Container(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Student Details",
                    style: TextStyle(color: Colors.black,
                        fontSize: 26,fontWeight: FontWeight.w700),),)
                ],),
              const SizedBox(height: 40,),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey,
                child: Image.asset("assets/user.jpg",),
              ),
              const SizedBox(height: 20,),
              Text(studentData["name"],style:const
              TextStyle(fontWeight: FontWeight.w500,fontSize: 22.47),),
              const SizedBox(height: 10,),
              Text("Age : ${studentData["age"]}",style: const
              TextStyle(fontWeight: FontWeight.w400,fontSize: 22.47),),
              const SizedBox(height: 20,),
              Text(studentData["email"],style:const
              TextStyle(fontWeight: FontWeight.w200,fontSize: 17.18),)
            ],),
        ),
      ),
    );
  }
}