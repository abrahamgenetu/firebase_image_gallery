import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowUpload extends StatefulWidget {
  final String? userId;
  const ShowUpload({Key? key, this.userId}) : super(key: key);

  @override
  State<ShowUpload> createState() => _ShowUploadState();
}

class _ShowUploadState extends State<ShowUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Images")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .collection("images")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (const Center(child: Text("No Images Found")));
          } else {
            return Swiper(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                String url = snapshot.data!.docs[index]['downloadURL'];
                return Image.network(
                  url,
                  height: 300,
                  fit: BoxFit.fitWidth,
                );
              },
              itemWidth: 300.0,
              layout: SwiperLayout.STACK,
            );
          }
        },
      ),
    );
  }
}
