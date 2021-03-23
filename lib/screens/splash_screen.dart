import 'package:flutter/material.dart';
import 'package:thenewsapp/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(),
      ),);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/TNA.png', height: MediaQuery.of(context).size.height * .13,),
              SizedBox(height: 15,),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
