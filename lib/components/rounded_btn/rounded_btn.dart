import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.circular,required this.color, required this.btnText, required this.onPressed});
  final double circular; 
  final Color color;
  final String btnText;
  final VoidCallback  onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(circular),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 60.0,
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}




class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
     Key? key,
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed, required int circular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
         
    borderRadius: BorderRadius.circular(20),
        gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        
        color: Colors.transparent,
        child: InkWell(
            onTap: (){ onPressed();},
            child: Center(
              child: child,
            )),
      ),
    );
  }
}