import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../students/student_list.dart';
import 'new_register.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {


  var registerResponse;

  @override
  void initState() {
    super.initState();
    subjectList();

  }

  void subjectList()async{
    Response response;
    response = await Dio().get(
      "https://nibrahim.pythonanywhere.com/registration/?api_key=C09b3",);
    setState(() {
      registerResponse=response.data;
    });

    print(registerResponse);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body:  registerResponse== null? Center(child: CircularProgressIndicator()): SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Registration",
                      style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
                  ],),
                SizedBox(height: MediaQuery.of(context).size.height/4),
                registerResponse["registrations"]==null?
                const Text("No Data",style: TextStyle(fontSize: 18),):
                Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14),
                  child: Card(
                    elevation: 2,
                    color: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child:  ListTile(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const Student()));
                      },
                      title:const Text("Registration Id:100",style: TextStyle(fontWeight: FontWeight.w500),),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded) ,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/4),
               // const Text("Registration Deleted",style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.w500),),
                const SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const NewRegister()));
                  },
                  child: Container(
                    height: 60,width: 180,
                    decoration: BoxDecoration(color: Colors.lightBlue.shade50,borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Text("New Registration",style: TextStyle(color: Colors.blueAccent.shade700),)),
                  ),
                )
              ],),
          ),
        )
    );
  }
}
