import 'dart:convert';
import 'package:classroom/registration/register_details.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'new_register.dart';
import 'package:http/http.dart' as http;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var registerResponse;
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    registerList();
  }

  void registerList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/registration/?api_key=C09b3"),);
    setState(() {
      registerResponse=jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body:  registerResponse== null?const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Registration",
                  style: TextStyle(color: Colors.black,fontSize: 26,
                      fontWeight: FontWeight.w700),),)
              ],),
            SizedBox(height: MediaQuery.of(context).size.height/4),
            registerResponse["registrations"]==[]?
            ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(),
              itemCount:registerResponse["registrations"].length ,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return   Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14),
                  child: Card(
                    elevation: 2,
                    color: HexColor("#D1D1D1"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child:  ListTile(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                 RegistrationDetails(id:"${registerResponse["registrations"][i]["id"]}")));
                      },
                      title: Text("Registration Id: ${registerResponse["registrations"][i]["id"]}",
                        style:const TextStyle(fontWeight: FontWeight.w500),),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded) ,
                    ),
                  ),
                );
              },
            )
          : const Text("No Data",style: TextStyle(fontSize: 18),),
            SizedBox(height: MediaQuery.of(context).size.height/4),
            registerResponse["registrations"]!=null?
             Text("Registration Deleted",
              style: TextStyle(fontSize: 20,color:HexColor("#0FAB76"),
                  fontWeight: FontWeight.w600),)
                :const SizedBox(),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: ()async{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                         NewRegister()));
              },
              child: Container(
                height: 48,width: 177,
                decoration: BoxDecoration(
                    color:Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text("New Registration",
                  style: TextStyle(color: HexColor("#007AFF"),
                      fontSize: 17,fontWeight: FontWeight.w600),)),
              ),
            )
          ],),
      ),
    );
  }
}