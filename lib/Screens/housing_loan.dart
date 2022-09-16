import 'package:awesome_icons/awesome_icons.dart';
import 'package:emi_calculator/Screens/app_home_screen.dart';
import 'package:emi_calculator/Widgets/navigation_drawer_for_housing_loan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:input_slider/input_slider.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Widgets/navigation_drawer_for_personal_loan.dart';
import '../api/pdf_api.dart';
import 'package:emi_calculator/models/emi_calculation.dart';

class HousingLoanHomeScreen extends StatefulWidget {
  const HousingLoanHomeScreen({Key? key}) : super(key: key);

  @override
  State<HousingLoanHomeScreen> createState() => _HousingLoanHomeScreenState();
}

class _HousingLoanHomeScreenState extends State<HousingLoanHomeScreen> {

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  final emilogic = EmiLogic();
  var formatter = NumberFormat('#,##0.' + "#" * 5);


  String stringEmi = '';

  String monthyEmi = '38593.51';

  final List _tenureTypes = [ 'Months', 'Years' ];
  String tenureType = "Years";
  bool _switchValue = true;
  double principalValue = 2000000.0;
  String principalPdf = '2000000';
  String ratePdf = '15';
  double rateValue = 15.0;
  dynamic tenureMonth = 7;
  final TextEditingController tenureController = TextEditingController(text: '7');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawerForHousingLoan(),
      appBar: AppBar(
        title: Text('Housing Loan'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppHomeScreen(),
            ));
          },
          icon: Icon(CupertinoIcons.back),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: BluePainter(),
        child: Padding(
          padding: isDesktop(context)?const EdgeInsets.fromLTRB(500, 50, 500, 0):const EdgeInsets.fromLTRB(25, 50, 25, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emiResultsWidget(),
                  isDesktop(context)?IconButton(
                      onPressed: () => _onBasicAlertPressed(context),
                      icon: Icon(FontAwesomeIcons.solidFilePdf,color: Colors.white,)):
                  IconButton(
                      onPressed: ()
                      async {
                        final pdfFile =
                        await PdfApi.generateCenteredText(principalPdf,ratePdf,'$tenureMonth',monthyEmi);
                        PdfApi.openFile(pdfFile);
                      },
                      icon: Icon(FontAwesomeIcons.solidFilePdf,color: Colors.white,))
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 150)),
              buildEmiPrincipalWidget(),
              const SizedBox(height: 15.5,),
              buildEmiInterestWidget(),
              buildEmiTenureWidget(),
              const SizedBox(height: 15.5,),
              buildCalculateButtonWidget(),
              const SizedBox(height: 15.5,),
            ],
          ),
        ),
      ),
    );
  }

  String convertMoney(double value)
  {
    // if(value>=10000000)
    // {
    // return ("₹"+(value/10000000).floor().toString() +" crores") ;
    // }
    if(value>=1000000)
    {
      return ("₹"+(value/100000).floor().toString() +" Lakhs") ;
    }
    else if(value>=1000)
    {
      return ("₹"+(value/1000).floor().toString()+"Thousand") ;
    }
    return '';
  }

  //Below are the following Input Widgets

  Widget buildEmiPrincipalWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 11,),
            Text('Enter Principal Amount'),
            SizedBox(width: 11,),
            Text('${convertMoney(principalValue)}')
          ],
        ),
        InputSlider(
          onChange: (value) {
            setState(() {
              principalValue = value;
            });
          },
          min: 0.0,
          max: 100000000.0,
          textFieldStyle: const TextStyle(fontSize: 15),
          decimalPlaces: 0,
          defaultValue: 2000000.0,
          textFieldSize: Size(130,40),

        ),
      ],
    );
  }

  Widget buildEmiInterestWidget() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 11,),
            Text('Enter Interest Amount'),
            SizedBox(width: 11,),
            Text('${rateValue.floor()} %')
          ],
        ),
        InputSlider(
          onChange: (value){
            setState(() {
              rateValue = value;
            });
          },
          min: 0.0,
          max: 100.0,
          textFieldStyle: const TextStyle(fontSize: 15),
          decimalPlaces: 0,
          defaultValue: 15.0,
          division: 100,
          textFieldSize: Size(130,40),

        ),
      ],
    );
  }

  Widget buildEmiTenureWidget() {

    return Container(
        padding: EdgeInsets.all(15.5),
        child: Column(
          children: [
            Row(
              children: [
                Text('Enter Tenure'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    flex: 4,
                    // fit: FlexFit.tight,
                    child: SizedBox(
                      width: 130,
                      height: 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: tenureController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(0, 0 , 0, 5)
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                ),
                SizedBox(width: 20,),

                Flexible(
                    flex: 1,
                    child: Column(
                        children: [
                          Text(
                              tenureType,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          Switch(
                              value: _switchValue,
                              onChanged: (bool value) {
                                if( value ) {
                                  tenureType = _tenureTypes[1];
                                } else {
                                  tenureType = _tenureTypes[0];
                                }

                                setState(() {
                                  _switchValue = value;
                                });
                              }

                          )
                        ]
                    )
                )
              ],
            ),
          ],
        )

    );

  }

  // Below is the Calculate button Widget and monthlyEmi Result Widget

  Widget buildCalculateButtonWidget() {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.white.withOpacity(0.3),
          boxShadow: [
            BoxShadow(
                blurRadius: 85.0,
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

          final holder = emilogic.handleCalculation(principalValue, rateValue, tenureType, tenureController);

          setState(() {
            monthyEmi = holder.toStringAsFixed(2);
            stringEmi = monthyEmi;
            principalPdf = principalValue.toStringAsFixed(2);
            int n = tenureType == "Years" ? int.parse(tenureController.text) * 12  : int.parse(tenureController.text);
            tenureMonth = n;
            ratePdf = rateValue.toStringAsFixed(0);

          });
        },
        child: const Text("Calculate",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
    );
  }

  Widget emiResultsWidget() {

    bool canShow = false;
    if(stringEmi.length>0){
      canShow= true;
    }
    return Container(
        child: canShow ? Column(
          children: [
            Text("Your Monthly EMI is",style: TextStyle(color: Colors.white),),
            Container(
              child: Text('₹'+formatter.format(double.parse('$monthyEmi'.replaceAll(",", ""))),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
            )
          ],
        ) : Column(
          children: [
            Text("Your Monthly EMI is",style: TextStyle(color: Colors.white),),
            Container(
              child: Text('₹38,593.51',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
            ),
          ],
        )
    );
  }


  _onBasicAlertPressed(BuildContext context) {
    Alert(
      context: context,
      title: "Dear User",
      desc: "Please use Mobile version to download summary of your EMI",
    ).show();
  }


}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height /3.3;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    // paint.color = Color.fromRGBO(0, 10, 238, 1);
    paint.color = Colors.deepPurple;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, height);
    ovalPath.quadraticBezierTo(width * 1.2, height * 3, width * 1, height * 0.75);
    paint.color = HexColor('C4BAE0');
    canvas.drawPath(ovalPath, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
