import 'package:classroom/registration/register_details.dart';
import 'package:classroom/students/student_list.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Registration",
                      style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
                  ],),
                const SizedBox(height: 40,),
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
                SizedBox(height:MediaQuery.of(context).size.height/1.6 ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const RegistrationDetails()));
                  },
                  child: Container(
                    height: 50,width: 170,
                    decoration: BoxDecoration(color: Colors.lightBlue.shade50
                        ,borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Text("New Registration",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                  ),
                )

              ],),
          ),
        ));
  }
}