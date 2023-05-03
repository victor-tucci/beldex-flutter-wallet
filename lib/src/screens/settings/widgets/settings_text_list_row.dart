import 'package:flutter/material.dart';

class SettingsTextListRow extends StatelessWidget {
  SettingsTextListRow({@required this.onTaped, this.title, this.widget,this.balanceVisibility,this.decimalVisibility,this.currencyVisibility,this.feePriorityVisibility});

  final VoidCallback onTaped;
  final String title;
  final Widget widget;
  final bool balanceVisibility;
  final bool decimalVisibility;
  final bool currencyVisibility;
  final bool feePriorityVisibility;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: balanceVisibility == false &&
            decimalVisibility == false &&
            currencyVisibility == false &&
            feePriorityVisibility == false ?Colors.grey:Colors.transparent,
        highlightColor:  balanceVisibility == false &&
            decimalVisibility == false &&
            currencyVisibility == false &&
            feePriorityVisibility == false ?Colors.grey:Colors.transparent,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        trailing: Icon(Icons.keyboard_arrow_right_outlined,size: 30,color: Color(0xff3F3F4D),),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                    color: Theme.of(context).primaryTextTheme.headline6.color),
              ),
            ),
            Flexible(child: widget)
          ],
        ),
        onTap: onTaped,
      ),
    );
  }
}
