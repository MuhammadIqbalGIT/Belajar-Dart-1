import 'package:flutter/material.dart';

class Menu1Page extends StatefulWidget {
  // Generate dummy items with random status (active or inactive)
  final List<String> dummyItems = List.generate(
      10,
      (index) =>
          'Item ${index + 1} ${index % 2 == 0 ? '(Active)' : '(Inactive)'}');

  @override
  _Menu1PageState createState() => _Menu1PageState();
}

class _Menu1PageState extends State<Menu1Page> {
  late TextEditingController _searchController;
  late List<String> filteredItems;
  bool isSearching = false;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    applyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu 1'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedFilter = value;
                applyFilter();
              });
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Active', 'Inactive'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  isSearching = true;
                  applyFilter();
                });
              },
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(child: Text('Tidak ditemukan item yang dicari'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return buildListItem(filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan item baru ketika tombol tambah ditekan
          navigateToAddItemPage(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildListItem(String itemName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(itemName),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteItem(itemName);
            },
          ),
          onTap: () {
            // Navigasi ke halaman edit item ketika item di klik
            navigateToEditItemPage(context, itemName);
          },
        ),
      ),
    );
  }

  void applyFilter() {
    if (selectedFilter == 'All') {
      filteredItems = widget.dummyItems.where((item) {
        final lowercaseItem = item.toLowerCase();
        final lowercaseSearch = _searchController.text.toLowerCase();
        return lowercaseItem.contains(lowercaseSearch);
      }).toList();
    } else if (selectedFilter == 'Active') {
      filteredItems = widget.dummyItems
          .where((item) =>
              item
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) &&
              item.contains('(Active)'))
          .toList();
    } else if (selectedFilter == 'Inactive') {
      filteredItems = widget.dummyItems
          .where((item) =>
              item
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) &&
              item.contains('(Inactive)'))
          .toList();
    }
  }

  void showItemNameDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item yang dipilih'),
          content: Text('Anda telah memilih item: $itemName'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addItem(String newItem) {
    setState(() {
      widget.dummyItems.add(newItem);
      applyFilter();
    });
  }

  void deleteItem(String itemName) {
    setState(() {
      widget.dummyItems.remove(itemName);
      applyFilter();
    });
  }

  void navigateToAddItemPage(BuildContext context) async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemPage(),
      ),
    );

    if (newItem != null) {
      addItem(newItem);
    }
  }

  void navigateToEditItemPage(BuildContext context, String itemName) async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(itemName: itemName),
      ),
    );

    if (updatedItem != null) {
      deleteItem(itemName);
      addItem(updatedItem);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class AddItemPage extends StatelessWidget {
  final TextEditingController _addItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addItemController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kembalikan item yang ditambahkan saat tombol 'Simpan' ditekan
                Navigator.pop(context, _addItemController.text.trim());
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditItemPage extends StatelessWidget {
  final String itemName;

  const EditItemPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _editItemController =
        TextEditingController(text: itemName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _editItemController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kembalikan item yang diperbarui saat tombol 'Simpan' ditekan
                Navigator.pop(context, _editItemController.text.trim());
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
