import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../students/students_detail.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {

  ScrollController? _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarCommon(context: context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Registration",
                      style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w500),),)
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
                        color: Colors.grey.shade100,
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
                                          StudentDetails(id: null,)));
                            }
                            );
                          },
                          child: const Padding(
                            padding:  EdgeInsets.only(top: 15, bottom: 2,right: 8,left: 8),
                            child: SizedBox(
                              height: 74,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 190.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 178.0,
                                              child: Text(
                                                  "Student Details",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("tiny",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("fcnsdj@gmail.com",
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
                                child:const Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child:const Text("Yes"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    showDialogInfo();
                    // await showDialog(
                    // context: context, builder: (context) {
                    //   Future.delayed( const Duration(seconds: 10), () {});
                    //   return Dialog(
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    //     child: DialogWidget(
                    //         title: "Delete",
                    //         msg:"Do you want to delete",
                    //         msgStyle:const
                    //         TextStyle(color: Colors.red,),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.pop(context, 'Cancel');
                    //             },
                    //             child: Text(
                    //               "No",
                    //             ),
                    //           ),
                    //           // InkWell(
                    //           //     borderRadius: BorderRadius.circular(10),
                    //           //     onTap: () async {
                    //           //       /// Function to delete general customer.
                    //           //       var response;
                    //           //       try {
                    //           //         response = await http.post(Uri.parse(
                    //           //           "$urlApi/customer/delete/${customerGeneral["data"]["General"][i]["id"]}?"
                    //           //               "company_id=$companyID&"
                    //           //               "domain=$domainCode&"
                    //           //               "posting_date=$apiToDate&description=${"Customer Deleted by in Mobile"}",),
                    //           //           headers: headers,);
                    //           //         var deleteresponse;
                    //           //         if (response.statusCode == 200) {
                    //           //           deleteresponse = jsonDecode(response.body);
                    //           //           if(!mounted)return;
                    //           //           setState(() {
                    //           //             deleteresponse = jsonDecode(response.body);
                    //           //             String invDelete = Bidi.stripHtmlIfNeeded("${deleteresponse["message"]}");
                    //           //             ToastAlert().toastfun("$invDelete");
                    //           //             onRefresher();
                    //           //             Navigator.pop(context, 'Delete');
                    //           //           });
                    //           //         }
                    //           //       }
                    //           //       catch (e) {}
                    //           //     },
                    //           //     child: deleteBox() // Confirmation of delete.
                    //           // ),
                    //         ]),
                    //   );
                    // });
                  },
                  child: Container(
                    height: 50,width: 170,
                    decoration: BoxDecoration(color: Colors.red.shade500
                        ,borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Text("Delete Registration",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                )

              ],),
          ),
        ));
  }
}



