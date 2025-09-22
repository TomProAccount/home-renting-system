import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/house.dart';
import '../../providers/user_provider.dart';
import '../../providers/house_provider.dart';

class HouseListWidget extends StatelessWidget {
  final List<House> houses;
  final bool isLoading;

  const HouseListWidget({
    super.key,
    required this.houses,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final houseProvider = Provider.of<HouseProvider>(context, listen: false);
    final user = userProvider.currentUser;

    // Don't render until the user is ready
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final role = user.role;

    void _showHouseDialog(House? house) {
      final _formKey = GlobalKey<FormState>();
      final _titleController = TextEditingController(text: house?.title ?? '');
      final _typeController = TextEditingController(text: house?.type ?? '');
      final _sizeController = TextEditingController(text: house?.size.toString() ?? '');
      final _priceController = TextEditingController(text: house?.price.toString() ?? '');
      String _internet = house?.internet ?? 'none';
      bool _furnished = house?.furnished ?? false;

      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(house == null ? 'Add New House' : 'Edit House'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (v) => v!.isEmpty ? 'Title is required' : null,
                    ),
                    TextFormField(
                      controller: _typeController,
                      decoration: const InputDecoration(labelText: 'Type'),
                      validator: (v) => v!.isEmpty ? 'Type is required' : null,
                    ),
                    TextFormField(
                      controller: _sizeController,
                      decoration: const InputDecoration(labelText: 'Size (m²)'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Size is required' : null,
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price (CHF)'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Price is required' : null,
                    ),
                    DropdownButtonFormField<String>(
                      value: _internet,
                      decoration: const InputDecoration(labelText: 'Internet'),
                      items: const [
                        DropdownMenuItem(value: 'none', child: Text('None')),
                        DropdownMenuItem(value: 'wifi', child: Text('WiFi')),
                        DropdownMenuItem(value: 'ethernet', child: Text('Ethernet')),
                      ],
                      onChanged: (value) => setState(() => _internet = value!),
                    ),
                    CheckboxListTile(
                      title: const Text('Furnished'),
                      value: _furnished,
                      onChanged: (value) => setState(() => _furnished = value!),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final size = double.tryParse(_sizeController.text) ?? 0.0;
                  final price = double.tryParse(_priceController.text) ?? 0.0;

                  final newHouse = House(
                    id: house?.id ?? '',
                    title: _titleController.text,
                    type: _typeController.text,
                    size: size,
                    price: price,
                    internet: _internet,
                    ownerId: user.id,
                    isActive: house?.isActive ?? true,
                    furnished: _furnished,
                  );

                  if (house == null) {
                    await houseProvider.addHouse(newHouse);
                  } else {
                    await houseProvider.updateHouse(newHouse);
                  }

                  Navigator.pop(context);
                },
                child: Text(house == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : houses.isEmpty && role == "student"
          ? const Center(child: Text('No houses available.'))
          : ListView.builder(
        itemCount: houses.length,
        itemBuilder: (context, index) {
          final house = houses[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(house.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${house.type}'),
                  Text('Size: ${house.size} m²'),
                  Text('Furnished: ${house.furnished ? "Yes" : "No"}'),
                  Text('Price: ${house.price} CHF/month'),
                  Text('Internet: ${house.internet == "none" ? "No" : house.internet}'),
                  if (role == "landlord")
                    Text('Status: ${house.isActive ? "Active" : "Inactive"}'),
                ],
              ),
              trailing: role == "landlord"
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(house.isActive ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => houseProvider.toggleHouseActive(house.id, house.isActive),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showHouseDialog(house),
                  ),
                ],
              )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: role == "landlord"
          ? FloatingActionButton(
        onPressed: () => _showHouseDialog(null),
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}
