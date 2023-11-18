import 'package:comprar_oque/models/itemList.dart';
import 'package:uuid/uuid.dart';

class BuyList {
  final String? id = const Uuid().toString();
  final String title;
  bool favorite = false;

  List<ItemList> items = [];

  BuyList(this.title);
}
