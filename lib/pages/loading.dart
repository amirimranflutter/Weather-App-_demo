import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffFB5E39),
            Color(0xffD02A02),
          ], begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/img/appstore.png",
              ),
              radius: 120,
            )),
            SizedBox(
              height: 40,
            ),
            SpinKitFadingCircle(
              color: Color(0xffFFFFFF),
              size: 90,
            ),
            SizedBox(height: 50,),
            Text("Made by Amir Imran",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 23),)
          ],
        ),
      ),
    );
  }
}
