import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final bool check;
  final String text;
  final Color color;

  const Cards({Key key, this.check, this.text, this.color}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      clipper: ShapeBorderClipper(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      elevation: 3,
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -20,
              right: 0,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: -20,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// check for tick mark
            check
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(1),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                           
                          ),
                        child: Container(
                          // margin: const EdgeInsets.all(8),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.green, width: 3),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                   text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 1,
                        color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}