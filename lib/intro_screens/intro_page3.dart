import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class IntroPage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white30,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("All set!",style: TextStyle(fontSize: 30),),
            SizedBox(height: 25,),
            const Text("Your App is ready to Go",style: TextStyle(fontSize: 20,color: Colors.black54),),
            SizedBox(height: 45,),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/ip3.json'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
