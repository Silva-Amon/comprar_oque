import 'package:comprar_oque/enums/itemCategory.dart';

import 'package:uuid/uuid.dart';

class Item {
  final String? id = const Uuid().v4().toString();
  final String title;
  double price;
  ItemCategory category;
  bool purchased = false;

  Item(this.title, this.price, this.category);
}
