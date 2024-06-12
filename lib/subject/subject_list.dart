import 'dart:convert';
import 'package:classroom/constants.dart';
import 'package:classroom/subject/subject_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Subject extends StatefulWidget {

  bool check = false;
  var register;
  Subject({Key? key, this.register,}) : super(key: key);

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  ScrollController? _controller;
  var subjectResponse,classResponse;
  List list=[],listId=[],listSize=[];

  @override
  void initState() {
    super.initState();
    subjectList();
    classList();
  }

  void subjectList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/subjects/?api_key=C09b3"),);
    setState(() {
      subjectResponse=jsonDecode(response.body);
    });
  }

  void classList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/classrooms/?api_key=C09b3"),);
    setState(() {
      classResponse=jsonDecode(response.body);
      for (int i = 0; i < classResponse["classroom"].length; i++) {
        list.add(classResponse['classroom'][i]["name"]);
        listId.add(classResponse['classroom'][i]["id"]);
        listSize.add(classResponse['classroom'][i]["size"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body: SingleChildScrollView(
        child:subjectResponse==null?const Center(child: CircularProgressIndicator()): Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Subjects",
                  style: TextStyle(color: Colors.black,
                      fontSize: 22,fontWeight: FontWeight.w500),),)
              ],),
            const SizedBox(height: 40,),
            ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(),
              itemCount: subjectResponse["subjects"].length,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return Padding(
                  padding:const  EdgeInsets.only(top: 6, left: 7, right: 7),
                  child: Card(
                    elevation: 0,
                    color: HexColor("#D1D1D1"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        if(!mounted)return;
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SubjectDetails(id:"${subjectResponse["subjects"][i]["id"]}" ,)));
                        }
                        );
                      },
                      child:  Padding(
                        padding:const  EdgeInsets.only(top: 15, bottom: 2,right: 8,left: 8),
                        child: SizedBox(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          child: Text(
                                              "${subjectResponse["subjects"][i]["name"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style:const TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("${subjectResponse["subjects"][i]["teacher"]}",
                                          overflow: TextOverflow.ellipsis,
                                          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:const  EdgeInsets.only(top: 0, bottom: 15),
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
                                              "${subjectResponse["subjects"][i]["credits"]}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style:const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight:FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    const    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width:100,
                                          child: Text("Credit",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 13,
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