import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

class FaqPage extends BasePage {
  @override
  String get title => S.current.faq;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                S.of(context).howCanWenhelpYou,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.15 / 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 90,
              height: 100,
              margin: EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/new-images/faq.png'),
            )
          ],
        ),
        SizedBox(height: 10.0),
        FutureBuilder(
          builder: (context, snapshot) {
            final faqItems = jsonDecode(snapshot.data.toString()) as List;

            return Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final itemTitle = faqItems[index]['question'].toString();
                    final itemChild = faqItems[index]['answer'].toString();

                    return Theme(
                      data: Theme.of(context).copyWith(
                          accentColor: settingsStore.isDarkTheme
                              ? Colors.white
                              : Colors.black,
                          dividerColor: Colors.transparent,
                          textSelectionTheme: TextSelectionThemeData(
                              selectionColor: Colors.green)),
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 15, right: 15.0, bottom: 8.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff434359)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(10)),
                        child: ExpansionTile(
                          title: Text(
                            itemTitle,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    itemChild,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  // separatorBuilder: (_, __) =>
                  //     Divider(color: Theme.of(context).dividerTheme.color, height: 1.0),
                  itemCount: faqItems == null ? 0 : faqItems.length,
                ),
              ),
            );
          },
          future: rootBundle.loadString(getFaqPath(context)),
        )
      ],
    );
  }

  String getFaqPath(BuildContext context) {
    final settingsStore = context.read<SettingsStore>();

    switch (settingsStore.languageCode) {
      case 'en':
        return 'assets/faq/faq_en.json';
      case 'de':
        return 'assets/faq/faq_de.json';
      default:
        return 'assets/faq/faq_en.json';
    }
  }
}
