import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysecond_app/Screens/login_screen.dart';
import 'package:mysecond_app/model/user_model.dart';

import '../image_upload/image_upload.dart';
import '../image_upload/show_image.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // @override
  // void initState() {
  //   //Todo: implement initstate
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/preons.png", fit: BoxFit.contain),
              ),
              const Text(
                "Welcome to Preons",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 116, 116)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 116, 116),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${loggedInUser.email} ",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 116, 116),
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                "${loggedInUser.uid} ",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 116, 116),
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: ((context) =>ImageUpload(userId:loggedInUser.uid ))));    
              }, child: Text("Upload Images")),

              ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: ((context) => ShowUpload(userId:loggedInUser.uid))));
              }, child: Text("Show Images")),
              // ActionChip(
              //     label: const Text("Logout"),
              //     onPressed: () {
              //       logout(context);
              //     }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }


_appbar()
{
  //getting the size of appbar
  final appBarHeight = AppBar().preferredSize.height;

  return PreferredSize(
      child: AppBar(
      title: const Text("Profile"),
      actions:[
        IconButton(
          onPressed: (){
          logout(context);
          }, 
          icon: Icon(Icons.logout),)
      ],),
      preferredSize: Size.fromHeight(appBarHeight));
}
}