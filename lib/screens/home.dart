import 'package:comprar_oque/models/purchaseList.dart';
import 'package:flutter/material.dart';

class HomePurchaseListWidget extends StatefulWidget {
  const HomePurchaseListWidget({super.key});

  @override
  State<HomePurchaseListWidget> createState() => _HomePurchaseListWidgetState();
}

class _HomePurchaseListWidgetState extends State<HomePurchaseListWidget> {
  final List _purchasLists = [
    PurchaseList(0, 'mock 1'),
    PurchaseList(1, 'mock 2'),
    PurchaseList(2, 'mock 3 com texto muito longoooo'),
  ];

  _setFav(PurchaseList purchaseList) {
    setState(() {
      purchaseList.fav = !purchaseList.fav;
    });
  }

  void routeToList(int listId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprar o quê?", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: _buildPurchaseListCards())))
      ]),
    );
  }

  List<Widget> _buildPurchaseListCards() {
    return _purchasLists
        .map(
          (purchaseList) => Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: IconButton(
                    onPressed: () => _setFav(purchaseList),
                    icon: const Icon(Icons.star),
                    color: !purchaseList.fav ? Colors.grey[400] : Colors.amber,
                  ),
                ),
                Flexible(
                  child: Text(purchaseList.title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                TextButton(
                  child: const Text("Abrir lista"),
                  onPressed: () {
                    /* TODO: realiza rota a tela de listas, buscando os dados da lista no SQlit  */
                  },
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
