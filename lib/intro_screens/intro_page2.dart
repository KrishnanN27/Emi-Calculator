import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class IntroPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: const Text("One of the easiest way to \n calculate EMI on your phone",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,),)),
            SizedBox(height: 45,),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/ip2.json'),
              ),
            ),
            SizedBox(height: 45,),
            const Text("Get Things you love at ease!",style: TextStyle(fontSize: 20,color: Colors.black54),),
            SizedBox(height: 20 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home),
                SizedBox(width: 15,),
                Icon(Icons.person),
                SizedBox(width: 15,),
                Icon(Icons.car_crash_rounded),
              ],
            )
          ],
        ),
      ),
    );
  }
}
