import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  /// to show tick button or not
  final bool check;
  final String text;
  final Color color;
  final String sectext;
  final String weight1;
  final String weight2;
  final String date;
  final String time;
  final String ticket;

  const Cards(
      {Key key,
      this.check,
      this.text,
      this.color,
      this.weight1,
      this.sectext,
      this.weight2,
      this.date,
      this.time,
      this.ticket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textMargin = const EdgeInsets.symmetric(horizontal: 10, vertical: 2);
    Color clr = Colors.white.withOpacity(.8);
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
              right: -35,
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
              bottom: -35,
              right: -10,
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
                          color: Colors.white),
                    ),
                  ),
                  //*time
                  time != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Time: $time',
                            style: TextStyle(fontSize: 13, color: clr),
                          ),
                        )
                      : SizedBox.shrink(),

                  //*date
                  date != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Date: $date',
                            style: TextStyle(fontSize: 13, color: clr),
                          ),
                        )
                      : SizedBox.shrink(),

                  //* seciondary text

                  sectext != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Challan: $sectext',
                            style: TextStyle(fontSize: 13, color: clr),
                          ),
                        )
                      : SizedBox.shrink(),

                  //* weight 1
                  weight1 != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Loaded wt: $weight1',
                            style: TextStyle(fontSize: 13, color: clr),
                          ),
                        )
                      : SizedBox.shrink(),
                  //* unloaded 2
                  weight2 != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Empty wt: $weight2',
                            style: TextStyle(fontSize: 13, color: clr),
                          ),
                        )
                      : SizedBox.shrink(),
                  //ticket number
                  ticket != null
                      ? Container(
                          margin: textMargin,
                          child: Text(
                            'Ticket No: $ticket',
                            style: TextStyle(fontSize: 13, color: clr),
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
