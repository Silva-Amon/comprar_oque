import 'package:comprar_oque/models/buyList.dart';
import 'package:comprar_oque/models/itemList.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final buyList = ModalRoute.of(context)!.settings.arguments as BuyList;

    return Scaffold(
      appBar: AppBar(
        title: Text(buyList.title),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: buyList.items.length,
        itemBuilder: (context, index) {
          // return buyList.items[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _addItem(buyList);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
