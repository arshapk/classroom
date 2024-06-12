import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../students/students_detail.dart';

class RegistrationDetails extends StatefulWidget {
  var id;
   RegistrationDetails({Key? key,this.id}) : super(key: key);

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {
  var regResponse;
  @override
  void initState() {
    super.initState();
    registerList();
  }

  void registerList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/registration/${widget.id}?api_key=C09b3"),);
    setState(() {
      regResponse=jsonDecode(response.body);
    });
    print(regResponse);
  }

  ScrollController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Registration",
                  style: TextStyle(color: Colors.black,
                      fontSize: 26,fontWeight: FontWeight.w700),),)
              ],),
            const SizedBox(height: 40,),
            ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(),
              itemCount: 5,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6, left: 7, right: 7),
                  child: Card(
                    elevation: 0,
                    color: HexColor("#D1D1D1"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if(!mounted)return;
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StudentDetails(id: null,)));
                        }
                        );
                      },
                      child:const Padding(
                        padding:  EdgeInsets.only(top: 5, bottom: 5,right: 14,left: 14),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 190.0,
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         SizedBox(
                                          width: 178.0,
                                          child: Text("No name",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("History",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("arsha@gmail.com",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 0, bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width:100,
                                          child: Text(
                                              "Age :22",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height:MediaQuery.of(context).size.height/14 ),
            GestureDetector(
              onTap: ()async{
                showDialogInfo() {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // Disallows dismissing the dialog by tapping outside it
                    builder: (BuildContext context) {
                      final textTheme = Theme.of(context)
                          .textTheme
                          .apply(displayColor: Theme.of(context).colorScheme.onSurface);
                      return CupertinoAlertDialog(
                        title:const  Text("Delete"),
                        content:const Text("Do you Want to delete"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child:const Text("No",style: TextStyle(color:Colors.blue),),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child:const Text("Yes",style: TextStyle(color:Colors.blue)),
                            onPressed: () async{
                            var  response = await http.post(
                                Uri.parse("https://nibrahim.pythonanywhere.com/registration/${widget.id}?api_key=C09b3"));
                            var deleteresponse;
                            print(response.statusCode);
                            if (response.statusCode == 200) {
                              deleteresponse = jsonDecode(response.body);
                              ToastAlert().toast("$deleteresponse");
                              Navigator.of(context).pop();
                            } else{
                              ToastAlert().toast("$deleteresponse");
                            }
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                showDialogInfo();
              },
              child: Container(
                height: 48,width: 193,
                decoration: BoxDecoration(color:HexColor('#F9614F')
                    ,borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("Delete Registration",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            )
          ],),
      ),
    );
  }
}