import 'dart:convert';
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
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    classDetails();
    subjectList();
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

  void classDetails()async{
    var response = await http.get(
      Uri.parse("https://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=C09b3"),);
    setState(() {
      data=jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:appBarCommon(context: context),
      body: SingleChildScrollView(
        child:data==null?  const Center(child: CircularProgressIndicator()):
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("${widget.name}",
                    style:const TextStyle(
                        color: Colors.black,fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),)
                ],
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 14,right: 14),
                child: SizedBox(
                  height: 66,
                  child: Card(
                    elevation: 2,
                    color: HexColor("#D1D1D1"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        isDense: false,
                        itemHeight: 50,
                        validator: (value) => value == null
                            ? ''
                            : null,
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          errorBorder: OutlineInputBorder( borderSide: BorderSide(color:  HexColor("#D1D1D1"))),
                          fillColor: HexColor("#D1D1D1"),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  HexColor("#D1D1D1"))),
                          contentPadding: const EdgeInsets.only(left: 10,right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color:  HexColor("#D1D1D1")
                            ),),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: HexColor("#D1D1D1")),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8,)),),
                          isDense: true,),
                        hint:const Text("Add Subject",style: TextStyle(
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var response = await http.patch(
                                Uri.parse("http://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=3D01B&subject=$dataID",));
                          var value=jsonDecode(response.body);
                          if(response.statusCode==200){
                            ToastAlert().toast("$value");
                          }
                          else{
                            ToastAlert().toast("${value["error"]}");
                          }
                        }},
                        child: Container(
                          height: 39,
                          width: 86,
                          decoration: BoxDecoration(color:HexColor("#AAC9BF"),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text("Add",style: TextStyle(
                                  color: HexColor("#0FAB76"),fontSize: 22,fontWeight: FontWeight.w500),)),),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              data["layout"]=="conference"?
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                physics:const BouncingScrollPhysics(),
                children:List.generate(data["size"], (index) {
                  return Padding(
                      padding:const EdgeInsets.only(left: 20,right:16),
                      child: Row(
                        children: [
                          Container(
                            height: 50,width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.black)),
                            child:const Icon(Icons.accessibility,size:24),
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
                            const Icon(Icons.accessibility),
                            const  SizedBox(width: 20,),
                             Expanded(
                              child: Container(
                                height: 60,
                                color: HexColor("#D1D1D1"),),
                            ),
                            const SizedBox(width: 20,),
                            const Icon(Icons.accessibility),
                          ],
                        ));
                  }),
              const SizedBox(height: 20,)
            ],),
        ),
      ),
    );
  }
}