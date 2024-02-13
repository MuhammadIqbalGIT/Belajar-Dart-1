import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  final TextEditingController _itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Item Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                labelText: 'Nama Item',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan item baru ke daftar
                final newItemName = _itemNameController.text.trim();
                if (newItemName.isNotEmpty) {
                  Navigator.pop(context, newItemName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Nama item tidak boleh kosong'),
                  ));
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
