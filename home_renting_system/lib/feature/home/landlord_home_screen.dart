import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandlordHomeScreen extends StatelessWidget {
  LandlordHomeScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Houses'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('houses')
            .where('ownerId', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No houses yet'));
          }

          final houses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: houses.length,
            itemBuilder: (context, index) {
              final house = houses[index];
              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text(house['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type: ${house['type']}'),
                      Text('Size: ${house['size']} m²'),
                      Text('Price: \$${house['price']}'),
                      Text('Internet: ${house['internet']}'),
                      Text('Rented: ${house['rented'] ? "Yes" : "No"}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHouseDialog(context, user.uid),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHouseDialog(BuildContext context, String ownerId) {
    final _titleController = TextEditingController();
    final _typeController = TextEditingController();
    final _sizeController = TextEditingController();
    final _priceController = TextEditingController();
    String _internet = 'none';
    bool _rented = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New House'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type (house/apartment)')),
              TextField(controller: _sizeController, decoration: const InputDecoration(labelText: 'Size (m²)'), keyboardType: TextInputType.number),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              DropdownButtonFormField<String>(
                value: _internet,
                decoration: const InputDecoration(labelText: 'Internet'),
                items: const [
                  DropdownMenuItem(value: 'none', child: Text('None')),
                  DropdownMenuItem(value: 'wifi', child: Text('WiFi')),
                  DropdownMenuItem(value: 'ethernet', child: Text('Ethernet')),
                ],
                onChanged: (value) => _internet = value!,
              ),
              CheckboxListTile(
                value: _rented,
                title: const Text('Rented'),
                onChanged: (value) => _rented = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final size = int.tryParse(_sizeController.text) ?? 0;
              final price = double.tryParse(_priceController.text) ?? 0.0;
              await FirebaseFirestore.instance.collection('houses').add({
                'ownerId': ownerId,
                'title': _titleController.text,
                'type': _typeController.text,
                'size': size,
                'price': price,
                'internet': _internet,
                'rented': _rented,
                'createdAt': FieldValue.serverTimestamp(),
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
