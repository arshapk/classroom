import 'package:classroom/registration/register_data.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../students/student_list.dart';
import '../subject/subject_list.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({Key? key}) : super(key: key);
  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
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
                    Center(child: Text("New Registration",
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
                      title:const Text("Select a Student",style: TextStyle(fontWeight: FontWeight.w500),),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded) ,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
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
                                    Subject(register: 1,)));
                      },
                      title:const Text("Select a Subject",style: TextStyle(fontWeight: FontWeight.w500),),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded) ,
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height/7 ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const Register()));
                  },
                  child: Container(
                    height: 60,width: 120,
                    decoration: BoxDecoration(color: Colors.green.shade300,borderRadius: BorderRadius.circular(8)),
                    child:const Center(child: Text("Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                )
              ],),
          ),
        ));
  }
}
