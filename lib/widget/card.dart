import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  final bool check;
  final String text;

  const Cards({Key key, this.check, this.text}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(widget.check?100:60),
            blurRadius: widget.check?15:8,
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          widget.check
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 20,
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
                  widget.text,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 1),
                ),
              ))
        ],
      ),
    );
  }
}
