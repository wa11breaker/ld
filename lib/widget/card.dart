import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  /// to show tick button or not
  final bool check;
  final String text;
  final Color color;
  final String secText;

  const Cards({Key key, this.check, this.text, this.color, this.secText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      clipper: ShapeBorderClipper(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevation: 3,
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 10,
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
            Positioned(
              bottom: -10,
              right: -5,
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
            check ? greenCheck() : SizedBox.shrink(),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 1,
                          color: Colors.white),
                    ),
                  ),
                  secText != null
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Weight:$secText',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.white),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget greenCheck() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(1),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white.withAlpha(200),
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
    );
  }
}
