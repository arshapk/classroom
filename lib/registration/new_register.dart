import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({Key? key}) : super(key: key);
  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
var subjectResponse,value,dataID,studentResponse,studentData,studValue;
List listData=[],listDataId=[],listStudent=[],listStudId=[];
var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    subjectList();
    studentList();
  }

  void subjectList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/subjects/?api_key=C09b3"),);
    setState(() {
      subjectResponse=jsonDecode(response.body);
      for (int i = 0; i < subjectResponse["subjects"].length; i++) {
        listData.add(subjectResponse['subjects'][i]["name"]);
        listDataId.add(subjectResponse['subjects'][i]["id"]);
      }
    });
  }

 void studentList()async{
   var response = await http.get(
     Uri.parse("https://nibrahim.pythonanywhere.com/students/?api_key=C09b3"),);
  setState(() {
    studentResponse=jsonDecode(response.body);
    for (int i = 0; i < studentResponse["students"].length; i++) {
      listStudent.add(studentResponse['students'][i]["name"]);
      listStudId.add(studentResponse['students'][i]["id"]);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                child: DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  isDense: false,
                  itemHeight: 50,
                  validator: (value) => value == null
                      ? 'Subject is required*'
                      : null,
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,

                    fillColor: HexColor("#D1D1D1"),
                    contentPadding: const EdgeInsets.only(left: 10,right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color:HexColor("#D1D1D1"),
                      ),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: HexColor("#D1D1D1"),),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8,)),),
                    isDense: true,),
                  hint:const Text("Select Subject",style: TextStyle(
                      color:Colors.black),),
                  items: listData.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          height: 45.0,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          width: double.infinity,
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              item.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                  value: value,
                  onChanged: (newValue) {
                    if(!mounted)return;
                    setState(() {
                      value = newValue;
                    });
                    for (int i = 0; i < listData.length; i++) {
                      if (value == listData[i]) {
                        dataID = listDataId[i];
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 14,right: 14),
                child: DropdownButtonFormField(
                  dropdownColor:Colors.white,
                  isExpanded: true,
                  isDense: false,
                  itemHeight: 50,
                  validator: (value) => value == null
                      ? 'Student is required*'
                      : null,
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: HexColor("#D1D1D1"),
                    contentPadding: const EdgeInsets.only(left: 10,right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: HexColor("#D1D1D1"),
                      ),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                          HexColor("#D1D1D1"),),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8,)),),
                    isDense: true,),
                  hint:const Text("Select Student",style: TextStyle(
                      color:Colors.black),),
                  items: listStudent.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          height: 45.0,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          width: double.infinity,
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child:   Text(
                              item.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                  value: studValue,
                  onChanged: (newValue) {
                    if(!mounted)return;
                    setState(() {
                      studValue = newValue;
                    });
                    for (int i = 0; i < listStudent.length; i++) {
                      if (studValue == listStudent[i]) {
                        studentData = listStudId[i];
                      }
                    }
                  },
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height/9 ),
              GestureDetector(
                onTap: ()async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final url = "http://nibrahim.pythonanywhere.com/registration/?api_key=C09b3&"
                        "subject=$dataID"
                        "&student=$studentData";
                    var response = await http.post(Uri.parse(url));
                    var valueResponse = jsonDecode(response.body);
                    if (response.statusCode == 200) {
                      ToastAlert().toast("$valueResponse");
                      Navigator.pop(context);
                    }
                    else {
                      ToastAlert().toast("${valueResponse["error"]}");
                    }
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //          RegistrationDetails()));
                },
                child: Container(
                  height: 48,width: 107,
                  decoration: BoxDecoration(color: HexColor("#0FAB76"),
                      borderRadius: BorderRadius.circular(8)),
                  child:const Center(child: Text("Register",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w600,fontSize: 17),)),
                ),
              )
            ],),
        ),
      ),
    );
  }
}