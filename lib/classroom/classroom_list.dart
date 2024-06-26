import 'dart:convert';
import 'package:classroom/classroom/classroom_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ClassRoom extends StatefulWidget {
  ClassRoom({Key? key}) : super(key: key);

  @override
  State<ClassRoom> createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom> {
  ScrollController? _controller;
  var classResponse;
  var len;

  void classList()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/classrooms/?api_key=C09b3"),);
    setState(() {
      classResponse=jsonDecode(response.body);
      len=classResponse.length;
    });
  }

  @override
  void initState() {
    super.initState();
    classList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCommon(context: context),
      body:classResponse==null?
      const Center(
          child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Class Rooms",
                  style: TextStyle(color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),),)
              ],
            ),
            const SizedBox(height: 40,),
            ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(),
              itemCount:classResponse["classrooms"].length ,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6, left: 7, right: 7),
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
                                      Room(id: "${classResponse["classrooms"][i]["id"]}"
                                          , name: "${classResponse["classrooms"][i]["name"]}",
                                          seat: "${classResponse["classrooms"][i]["size"]}",)));}
                        );
                      },
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2,right: 8,left: 8),
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
                                              "${classResponse["classrooms"][i]["layout"]}",
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
                                        Text(
                                          "${classResponse["classrooms"][i]["name"]}",
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
                                              "${classResponse["classrooms"][i]["size"]}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style:const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight:FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    const  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width:100,
                                          child: Text(
                                              "Seats",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:FontWeight.w400)),
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