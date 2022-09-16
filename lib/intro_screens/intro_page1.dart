import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';


class IntroPage1 extends StatelessWidget {

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
            const Text("Emi Calculator",style: TextStyle(fontSize: 30),),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/ip1.json'),
              ),
            ),

            const Text("Welcome",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Center(
              child: const Text("One Step solution for your financial \n calculators and loan manager to"
                  "\n track your loan progress",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black54),),
            ),
          ],
        ),
      ),
    );
  }
}
