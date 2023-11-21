import 'package:comprar_oque/enums/itemCategory.dart';
import 'package:comprar_oque/models/item.dart';
import 'package:uuid/uuid.dart';

class BuyList {
  final String? id = const Uuid().v4().toString();
  final String title;
  bool favorite = false;

  List<Item> items = [Item("teste", 20, ItemCategory.comida)];

  BuyList(this.title);
}
