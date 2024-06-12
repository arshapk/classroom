import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Room extends StatefulWidget {
  var id,name,seat;
  Room({Key? key, this.id,this.name,this.seat}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  var data,value,dataID;
  List listData=[],listDataId=[];
  ScrollController? _controller;
  var subjectResponse;

  @override
  void initState() {
    super.initState();
    classDetails();
    subjectList();
  }

  void subjectList()async{
    var  response = await Dio().get(
      "https://nibrahim.pythonanywhere.com/subjects/?api_key=C09b3",);
    setState(() {
      subjectResponse=response.data;
      for (int i = 0; i < subjectResponse["subjects"].length; i++) {
        listData.add(subjectResponse['subjects'][i]["name"]);
        listDataId.add(subjectResponse['subjects'][i]["id"]);
      }
    });

  }

  void classDetails()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=C09b3"),);
    setState(() {
      data=jsonDecode(response.body);
      print("https://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=C09b3");
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar:appBarCommon(context: context),
          body: SingleChildScrollView(
            child:data==null?  const Center(child: CircularProgressIndicator()):Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("${widget.name}",
                        style:const TextStyle(
                            color: Colors.black,fontSize: 26,
                            fontWeight: FontWeight.w500),
                      ),)
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 14,right: 14),
                    child: Card(
                      elevation: 2,
                      color: Colors.grey.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: DropdownButtonFormField(
                          dropdownColor: Theme.of(context).brightness == Brightness.dark?
                          HexColor("1F2937"):Colors.white,
                          isExpanded: true,
                          isDense: false,
                          itemHeight: 50,
                          validator: (value) => value == null
                              ? 'Subject is required*'
                              : null,
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 10,right: 10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: HexColor("#a1a1aa").withOpacity(.7)
                              ),),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color:
                                  Colors.grey.shade300),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8,)),),
                            isDense: true,),
                          hint:const Text("Select Subject",style: TextStyle(
                              color:Colors.grey),),
                          items: listData.map((item) =>
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
                        trailing: GestureDetector(
                          onTap: ()async {
                            print("http://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=3D01B&subject=$dataID");

                            var response = await http.patch(Uri.parse("http://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=3D01B&subject=$dataID",));
                            var value=jsonDecode(response.body);
                            print(value);
                            if(response.statusCode==200){
                              ToastAlert().toastfun("$value");
                            }
                            else{
                              ToastAlert().toastfun("$value");
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             Subject(register: 0,)));
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(color: Colors.green.shade50,borderRadius: BorderRadius.circular(8)),
                            child:const Center(child: Text("Add",style: TextStyle(color: Colors.green),)),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  data["layout"]=="conference"?
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    mainAxisSpacing: 3,
                    physics:const BouncingScrollPhysics(),
                    children:List.generate(data["size"], (index) {
                      return Padding(
                          padding:const EdgeInsets.only(left: 20,right:20),
                          child: Row(
                            children: [
                              Container(
                                height: 40,width: 40,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),border: Border.all(color: Colors.black)),
                                child:const Icon(Icons.accessibility),
                              )

                            ],
                          ));
                    },
                    ),):
                  ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding:const  EdgeInsets.only(),
                      itemCount: data["size"],
                      physics:const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                            padding:const EdgeInsets.only(left: 20,right:20),
                            child: Row(
                              children: [
                                const Icon(Icons.switch_right),
                                const  SizedBox(width: 20,),
                                 Expanded(
                                  child: Container(
                                    height: 60,
                                    color: Colors.grey.shade200,),
                                ),
                                const SizedBox(width: 20,),
                                const Icon(Icons.switch_right),
                              ],
                            ));
                      }),
                  const SizedBox(height: 20,)
                ],),
            ),
          ),
        )
    );
  }
}