import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../subject/subject_list.dart';

class Room extends StatefulWidget {
  var id,name,seat;
  Room({Key? key, this.id,this.name,this.seat}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  var data;
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    classDetails();
    print(widget.id);

  }

  void classDetails()async{
    Response response;
    response = await Dio().get(
      "https://nibrahim.pythonanywhere.com/classrooms/${widget.id}?api_key=C09b3",);
    setState(() {
      data=response.data;
    });

    print(data);
    //print(data["name"]);
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar:appBarCommon(context: context),
          body: SingleChildScrollView(
            child:data==null?  Center(child: CircularProgressIndicator()):Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("${widget.name}",
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
                      child: ListTile(
                        title: const Text("Add Subject",style: TextStyle(fontWeight: FontWeight.w500),),
                        trailing: GestureDetector(
                          onTap: ()async {

                            // var response = await http.post(Uri.parse("https://nibrahim.pythonanywhere.com/clasrooms/${widget.id}?api_key=C09b3"
                            //     "&subject=",
                            // ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Subject(register: 0,)));
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
                  SizedBox(height: 10,),

                  ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding:  EdgeInsets.only(),
                      itemCount: data.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                            padding: EdgeInsets.only(left: 20,right:20),
                            child: Row(
                              children: [
                                Icon(Icons.switch_right),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    color: Colors.grey.shade200,),
                                ),
                                SizedBox(width: 20,),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: List.generate(data["size"], (index) =>
                                Icon(Icons.switch_right),
                                //  ),
                                //   ),


                              ],
                            ));}),
                  SizedBox(height: 20,)


                ],),
            ),
          ),
        )
    );
  }
}

