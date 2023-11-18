import 'package:comprar_oque/enums/ItemCategory.dart';
import 'package:comprar_oque/models/item.dart';
import 'package:uuid/uuid.dart';

class BuyList {
  final String? id = const Uuid().toString();
  final String title;
  bool favorite = false;

  List<Item> items = [Item("teste", 20, ItemCategory.food)];

  BuyList(this.title);
}
