import 'package:flutter/material.dart';
import '../constants.dart';
import 'new_register.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    super.initState();}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body:  SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Registration",
                      style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
                  ],),
                SizedBox(height: MediaQuery.of(context).size.height/4),
                const Text("No Data",style: TextStyle(fontSize: 18),),
                SizedBox(height: MediaQuery.of(context).size.height/4),
                const Text("Registration Deleted",style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.w500),),
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
