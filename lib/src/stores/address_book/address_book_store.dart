import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:hive/hive.dart';

import '../../../l10n.dart';

part 'address_book_store.g.dart';

class AddressBookStore = AddressBookStoreBase with _$AddressBookStore;

abstract class AddressBookStoreBase with Store {
  AddressBookStoreBase({required this.contacts}) {
    updateContactList();
  }

  @observable
  List<Contact> contactList=[];

  @observable
  bool isValid=false;

  @observable
  String? errorMessage;

  Box<Contact> contacts;

  @action
  Future add({required Contact contact}) async => contacts.add(contact);

  @action
  Future updateContactList() async => contactList = contacts.values.toList();

  @action
  Future update({required Contact contact}) async => contact.save();

  @action
  Future delete({required Contact contact}) async => await contact.delete();

  void validateContactName(String value,AppLocalizations t) {
    const pattern = '''^[^`,'"]{1,32}\$''';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    errorMessage = (isValid ? '' : t.error_text_contact_name);
  }

  void validateAddress(String value, {CryptoCurrency? cryptoCurrency,required AppLocalizations t}) {
    // XMR (95, 106), ADA (59, 92, 105), BCH (42), BNB (42), BTC (34, 42), DASH (34), EOS (42),
    // ETH (42), LTC (34), NANO (64, 65), TRX (34), USDT (42), XLM (56), XRP (34)
    const pattern = '^[0-9a-zA-Z]{95}\$|^[0-9a-zA-Z]{34}\$|^[0-9a-zA-Z]{42}\$|^[0-9a-zA-Z]{56}\$|^[0-9a-zA-Z]{59}\$|^[0-9a-zA-Z_]{64}\$|^[0-9a-zA-Z_]{65}\$|^[0-9a-zA-Z]{92}\$|^[0-9a-zA-Z]{105}\$|^[0-9a-zA-Z]{106}\$|^[0-9a-zA-Z]{97}\$|^[0-9a-zA-Z]{96}\$';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    if (isValid && cryptoCurrency != null) {
      switch (cryptoCurrency) {
        case CryptoCurrency.bdx:
          isValid = (value.length == 95)||(value.length == 97)||(value.length == 96)||(value.length == 106);
          break;
        case CryptoCurrency.xmr:
          isValid = (value.length == 95)||(value.length == 106)||(value.length == 97)||(value.length == 96);
          break;
        case CryptoCurrency.ada:
          isValid = (value.length == 59)||(value.length == 92)||(value.length == 105);
          break;
        case CryptoCurrency.bch:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.bnb:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.btc:
          isValid = (value.length == 34)||(value.length == 42);
          break;
        case CryptoCurrency.dash:
          isValid = (value.length == 34);
          break;
        case CryptoCurrency.eos:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.eth:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.ltc:
          isValid = (value.length == 34);
          break;
        case CryptoCurrency.nano:
          isValid = (value.length == 64)||(value.length == 65);
          break;
        case CryptoCurrency.trx:
          isValid = (value.length == 34);
          break;
        case CryptoCurrency.usdt:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.xlm:
          isValid = (value.length == 56);
          break;
        case CryptoCurrency.xrp:
          isValid = (value.length == 34);
          break;
      }
    }

    errorMessage = (isValid ? '' : t.error_text_address)!;
  }
}
