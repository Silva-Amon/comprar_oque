import 'package:uuid/uuid.dart';

class ItemList {
  final String? id = const Uuid().toString();
  final String title;
  double price;
  bool purchased = false;

  ItemList(this.title, this.price);
}
