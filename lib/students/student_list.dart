import 'dart:convert';
import 'package:classroom/students/students_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);
  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {

  ScrollController? _controller;
  var studentResponse;

  @override
  void initState() {
    super.initState();
    studentList();
  }

  void studentList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/students/?api_key=C09b3"),);
    setState(() {
      studentResponse=jsonDecode(response.body);
      print(studentResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body:
      SingleChildScrollView(
        child:studentResponse==null?
        const Center(child: CircularProgressIndicator()):
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(child: Text("Students",
                    style: TextStyle(
                        color: Colors.black,fontSize: 26,fontWeight: FontWeight.w700),),),
                )
              ],),
            const SizedBox(height: 40,),
            ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(),
              itemCount: studentResponse["students"].length,
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
                                      StudentDetails(id:"${studentResponse["students"][i]["id"]}")));
                        }
                        );
                      },
                      child:  Padding(
                        padding:const  EdgeInsets.only(top: 15, bottom: 2,right: 14,left: 14),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 200.0,
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 190.0,
                                          child: Text(
                                              "${studentResponse["students"][i]["name"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style:const TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("${studentResponse["students"][i]["email"]}",
                                          style:const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0, bottom: 15),
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
                                              "Age :${studentResponse["students"][i]["age"]}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style:const TextStyle(
                                                  fontSize: 17,
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
          ],),
      ),
    );
  }
}