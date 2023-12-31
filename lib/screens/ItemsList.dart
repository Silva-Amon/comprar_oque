import 'package:comprar_oque/models/buyList.dart';
import 'package:comprar_oque/models/item.dart';
import 'package:comprar_oque/screens/newItem.dart';
import 'package:comprar_oque/utils/CurrencyInputFormatter.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListWidget extends StatefulWidget {
  const ItemListWidget({super.key});

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  routeToAddNewItem(BuyList buyList) {
    addItem(Item newItem) {
      setState(() {
        buyList.items.add(newItem);
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewItemWidget(onItemAdded: addItem)),
    );
  }

  _deleteItem(BuyList buyList, Item item) {
    setState(() {
      buyList.items.remove(item);
    });
  }

  _setPurchasedItem(BuyList buyList, Item item, bool? purchased) {
    setState(() {
      buyList.items
          .firstWhere((existItem) => existItem.id == item.id)
          .purchased = purchased ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buyList = ModalRoute.of(context)!.settings.arguments as BuyList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          buyList.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(children: _buildItemListCards(buyList)))),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          routeToAddNewItem(buyList);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildItemListCards(BuyList buyList) {
    return buyList.items
        .map((item) => GestureDetector(
              onTap: () => {},
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(Colors.blue),
                          value: item.purchased,
                          onChanged: (bool? purchased) =>
                              _setPurchasedItem(buyList, item, purchased)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 10.0),
                      child: Text(item.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              decoration: item.purchased
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                    Flexible(
                      child: Text(
                          CurrencyInputFormatter.formatCurrency(
                              item.price.toString()),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              decoration: item.purchased
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: IconButton(
                        onPressed: () async {
                          if (await confirm(
                            context,
                            title: const Text('Deletar'),
                            content: const Text(
                                'Deseja realmente deletar o item da sua lista?'),
                            textOK: const Text('Sim'),
                            textCancel: const Text('Não'),
                          )) {
                            _deleteItem(buyList, item);
                          }
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }
}
