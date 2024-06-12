import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

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
    print(widget.id);
  }

  void subjectDetails()async{
    Response response;
    response = await Dio().get(
      "https://nibrahim.pythonanywhere.com/subjects/${widget.id}?api_key=C09b3",);
  setState(() {
    subjectData=response.data;
  });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body: SingleChildScrollView(
            child: subjectData==null?const Center(child: CircularProgressIndicator()): Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Subject Details",
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
                Text(subjectData["name"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                const SizedBox(height: 10,),
                Text(subjectData["teacher"],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),),
                const  SizedBox(height: 20,),
                Text("Credit : ${subjectData["credits"]}",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13),)
              ],
            ),
          ),
        ));
  }
}
