import 'package:comprar_oque/models/buyList.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class HomeBuyListWidget extends StatefulWidget {
  const HomeBuyListWidget({super.key});

  @override
  State<HomeBuyListWidget> createState() => _HomeBuyListWidgetState();
}

class _HomeBuyListWidgetState extends State<HomeBuyListWidget> {
  final List<BuyList> _buyList = [
    BuyList('Mercado'),
    BuyList('Feira'),
    BuyList('Roupas'),
  ];

  TextEditingController itemController = TextEditingController();

  void addItem() {
    String newItem = itemController.text;
    if (newItem.isNotEmpty) {
      setState(() {
        _buyList.add(BuyList(newItem));
        itemController.clear();
      });
    }
  }

  _setFavorite(BuyList buyList) {
    setState(() {
      buyList.favorite = !buyList.favorite;
    });
  }

  _deleteItem(BuyList buyList) {
    setState(() {
      _buyList.remove(buyList);
    });
  }

  void routeToList(BuyList buyList) {
    Navigator.pushNamed(context, "/list", arguments: buyList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Planejamento de compras",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      hintText: 'Nova lista de compras...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addItem,
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(children: _buildBuyListCards()))),
        ],
      ),
    );
  }

  List<Widget> _buildBuyListCards() {
    return _buyList
        .map((buyList) => GestureDetector(
              onTap: () => routeToList(buyList),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: IconButton(
                        onPressed: () => _setFavorite(buyList),
                        icon: const Icon(Icons.star),
                        color:
                            !buyList.favorite ? Colors.grey[400] : Colors.amber,
                      ),
                    ),
                    Flexible(
                      child: Text(buyList.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: IconButton(
                        onPressed: () async {
                          if (await confirm(
                            context,
                            title: const Text('Deletar'),
                            content: const Text(
                                'Deseja realmente deletar a lista e todos os seus items?'),
                            textOK: const Text('Sim'),
                            textCancel: const Text('Não'),
                          )) {
                            _deleteItem(buyList);
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
