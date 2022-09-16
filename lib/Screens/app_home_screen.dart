import 'package:emi_calculator/Screens/car_loan.dart';
import 'package:emi_calculator/Screens/personal_loan.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'housing_loan.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('C4BAE0'),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 750,
              maxWidth: 500,
              minHeight: 750,
              minWidth: 500
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2,color: Colors.white30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    child:   CircleAvatar(
                      radius: 170
                      ,
                      child: ClipOval(
                        child: Image.asset("assets/home.jpg",
                        width: 270,
                        height: 270,
                        fit: BoxFit.cover,),
                      ),
              ),
                  ),
                 Container(
                   decoration: const BoxDecoration(
                     // color: Colors.white.withOpacity(0.3),
                       boxShadow: [
                         BoxShadow(
                             blurRadius: 80.0,
                             offset: Offset(28, 28),
                             color: Color(0xFFA7A9AF)
                         )
                       ]
                   ),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         minimumSize: Size(270, 50),
                         primary: HexColor('C4BAE0'),
                         onPrimary: Colors.deepPurpleAccent
                     ),
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                         return HousingLoanHomeScreen();
                       }));
                     },
                     child: const Text("Housing Loan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                   ),
                 ),
                 Container(
                   decoration: const BoxDecoration(
                       boxShadow: [
                         BoxShadow(
                             blurRadius: 80.0,
                             offset: Offset(28, 28),
                             color: Color(0xFFA7A9AF)
                         )
                       ]
                   ),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         minimumSize: Size(270, 50),
                         primary: HexColor('C4BAE0'),
                         onPrimary: Colors.deepPurpleAccent
                     ),
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                         return PersonalLoanHomeScreen();
                       }));
                     },
                     child: const Text("Personal Loan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                   ),
                 ),
                  Container(
                    decoration: const BoxDecoration(
                      // color: Colors.white.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 80.0,
                              offset: Offset(28, 28),
                              color: Color(0xFFA7A9AF)
                          )
                        ]
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(270, 50),
                          primary: HexColor('C4BAE0'),
                          onPrimary: Colors.deepPurpleAccent
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CarLoanHomeScreen();
                        }));
                      },
                      child: const Text("Car Loan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
