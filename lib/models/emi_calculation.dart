import 'dart:math';
import 'package:flutter/material.dart';



class EmiLogic {

  double handleCalculation(double principalValue, double rateValue, String tenureType, TextEditingController tenureController ) {

    //  Amortization
    //  amortization = Payment amount per period
    //  P = Initial Principal (loan amount)
    //  r = Interest rate
    //  n = Total number of payments or periods

    dynamic amortization = 0.0;
    double P = principalValue ;
    double r =  rateValue/ 12 / 100;
    int n = tenureType == "Years" ? int.parse(tenureController.text) * 12  : int.parse(tenureController.text);

    amortization = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));
    return amortization;

  }

}