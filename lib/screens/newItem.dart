import 'package:comprar_oque/enums/itemCategory.dart';
import 'package:comprar_oque/models/item.dart';
import 'package:comprar_oque/utils/currencyInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewItemWidget extends StatefulWidget {
  const NewItemWidget({super.key, required this.onItemAdded});
  final Function(Item) onItemAdded;

  @override
  State<NewItemWidget> createState() => _NewItemWidgetState();
}

class _NewItemWidgetState extends State<NewItemWidget> {
  final TextEditingController titleItemController = TextEditingController();
  final TextEditingController priceItemController = TextEditingController();
  ItemCategory? categoryItemSelected = ItemCategory.values.first;

  onlyNumbers(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo item a ser comprado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleItemController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
                controller: priceItemController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true)),
            DropdownButton<ItemCategory>(
              value: ItemCategory.values.first,
              onChanged: (ItemCategory? newValue) {
                setState(() {
                  categoryItemSelected = newValue;
                });
              },
              items: ItemCategory.values.map((ItemCategory itemCategory) {
                return DropdownMenuItem<ItemCategory>(
                  value: itemCategory,
                  child: Text(itemCategory.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Item newItem = Item(
                    titleItemController.text,
                    double.parse(onlyNumbers(priceItemController.text)),
                    categoryItemSelected!);
                if (newItem.title.isNotEmpty && newItem.price > 0) {
                  widget.onItemAdded(newItem);
                  Navigator.pop(context); // Close the add item screen
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
