import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker/model/user_model.dart';
import 'package:gps_tracker/screens/login_screen.dart';
import 'package:gps_tracker/screens/mapScreen.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen ({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel  loggedUser = UserModel();
    final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("user")
    .doc(user!.uid)
    .get()
    .then((value) => {
      setState(() {
        loggedUser = UserModel.fromMap(value.data());
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Location Tracker"), centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Colors.black, size: 50,),
                  Image.asset("assets/images/avatar.png", width: 50,)
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(18.0),
            child: Text("Dashboard Options",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),),
           Padding(padding: const EdgeInsets.all(12.0),
           child: Center(
             child: Wrap(
               spacing: 20.0,
               runSpacing: 20.0,
               children: [
                 GestureDetector(
                onTap: () {},
                 child: SizedBox(width: 160,
                 height: 160,
                     child: Card(
                       color: Color.fromARGB(255, 255, 255, 255),
                       elevation: 20,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8.0)
                       ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               Image.asset("assets/images/plus.png", width: 64, height: 70,),
                               const SizedBox(height: 10,),
                               const Text("Add Device", style: TextStyle(
                                 color:  Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 15)
                               ),
                               const SizedBox(height: 5.0,),

                             ],
                           ),
                         ),
                       ),
                     ),)),
                 GestureDetector(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapScreen()));
                     },
                     child: SizedBox(width: 160,
                       height: 160,
                       child: Card(
                         color: Color.fromARGB(255, 255, 255, 255),
                         elevation: 20,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0)
                         ),
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Image.asset("assets/images/map.png", width: 64, height: 70,),
                                 const SizedBox(height: 10,),
                                 const Text("View Devices", style: TextStyle(
                                     color:  Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 15)
                                 ),
                                 const SizedBox(height: 5.0,),

                               ],
                             ),
                           ),
                         ),
                       ),)),
                 GestureDetector(
                     onTap: () {},
                     child: SizedBox(width: 160,
                       height: 160,
                       child: Card(
                         color: Color.fromARGB(255, 255, 255, 255),
                         elevation: 20,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0)
                         ),
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Image.asset("assets/images/history.png", width: 64,),
                                 const SizedBox(height: 10,),
                                 const Text("Device History", style: TextStyle(
                                     color:  Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 15)
                                 ),
                                 const SizedBox(height: 5.0,),

                               ],
                             ),
                           ),
                         ),
                       ),)),
                 GestureDetector(
                     onTap: () {},
                     child: SizedBox(width: 160,
                       height: 160,
                       child: Card(
                         color: Color.fromARGB(255, 255, 255, 255),
                         elevation: 20,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0)
                         ),
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Image.asset("assets/images/delete.png", width: 64,),
                                 const SizedBox(height: 10,),
                                 const Text("Delete Device", style: TextStyle(
                                     color:  Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 15)
                                 ),
                                 const SizedBox(height: 5.0,),

                               ],
                             ),
                           ),
                         ),
                       ),))
,


               ],
             ),
           ),
           )
          ],
        ),
    ));
  }

  Future<void> logout () async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
