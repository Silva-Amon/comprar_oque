import 'package:comprar_oque/models/item.dart';
import 'package:uuid/uuid.dart';

class BuyList {
  final String? id = const Uuid().v4().toString();
  final String title;
  bool favorite = false;

  List<Item> items = [];

  BuyList(this.title);
}
