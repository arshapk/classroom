import 'package:classroom/registration/registration.dart';
import 'package:classroom/students/student_list.dart';
import 'package:classroom/subject/subject_list.dart';
import 'package:flutter/material.dart';
import 'classroom/classroom_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class Room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var greeting = "";
  void greetings(){
    int hours=DateTime.now().hour;
    if(hours>=1 && hours<11.59){
      if(!mounted)return;
      setState(() {
        greeting = "Good Morning";
      });
    } else if(hours>=12 && hours<16){
      if(!mounted)return;
      setState(() {
        greeting = "Good AfterNoon";
      });
    } else if(hours>=16 && hours<21){
      if(!mounted)return;
      setState(() {
        greeting = "Good Evening";
      });
    } else if(hours>=21 && hours<=24){
      if(!mounted)return;
      setState(() {
        greeting = "Good Night";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    greetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: .5,
        title:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello,",
              style: TextStyle(
                fontSize: 17.0,color: Colors.black,
                fontWeight: FontWeight.bold ,
              ),
            ),
            Text(greeting,
              style:const TextStyle(
                fontSize: 17.0,color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.yellow.shade800,
            ),
            onPressed: () async {

            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,right: 14,left: 14),
            child: Column(
              children: [
              Card(
                color: Colors.greenAccent.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Student()));
                  },
                  title:const Center(child:  Text("Students")),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.blueAccent.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Subject()));
                  },
                  title:const Center(child: Text("Subjects")),

                ),
              ),
              const SizedBox(height: 20,),
              Card(
                elevation: 2,
                color: Colors.red.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                 ClassRoom()));
                  },
                  title: const Center(child: Text("Class Rooms")),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.yellow.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               const Registration()));
                  },
                  title:const Center(child: Text("Registration")),

                ),
              ),
              const SizedBox(height: 5,),]),
          )

        ),
      ),
    );
  }
}
