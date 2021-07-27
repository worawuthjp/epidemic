import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShowBox extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String title;
  final String text;
  final double textSize;
  final double titleSize;
  final double titleHeight;
  final int total;
  final double totalSize;
  final double totalHeight;
  final int newTotal;
  final double newtotalSize;
  final double newtotalHeight;

  const ShowBox(
      {Key key,
      this.height,
      this.width,
      this.backgroundColor,
      this.title,
      this.text,
      this.textSize,
      this.titleSize,
      this.titleHeight,
      this.total,
      this.totalSize,
      this.totalHeight,
      this.newTotal,
      this.newtotalSize,
      this.newtotalHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: height,
        width: width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: title + '\n',
                style: GoogleFonts.kanit(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                    height: titleHeight)),
            TextSpan(
              text: '${NumberFormat("#,###,###").format(total)}\n',
              style: GoogleFonts.kanit(
                  fontSize: totalSize,
                  fontWeight: FontWeight.bold,
                  height: totalHeight),
            ),
            TextSpan(
                text: '${NumberFormat("#,###,###").format(newTotal)}',
                style: GoogleFonts.kanit(
                    fontSize: newtotalSize,
                    fontWeight: FontWeight.bold,
                    height: newtotalHeight))
          ]),
        ),
      ),
    );
  }
}
