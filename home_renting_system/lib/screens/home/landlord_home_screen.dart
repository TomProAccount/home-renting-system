import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/house.dart';
import '../../providers/house_provider.dart';
import 'labeled_text_field.dart';

class LandlordHomeScreen extends StatefulWidget {
  const LandlordHomeScreen({super.key});

  @override
  State<LandlordHomeScreen> createState() => _LandlordHomeScreenState();
}

class _LandlordHomeScreenState extends State<LandlordHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Safe call to provider after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final houseProvider = Provider.of<HouseProvider>(context, listen: false);
      final user = FirebaseAuth.instance.currentUser!;
      houseProvider.getHousesByOwner(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser!;
    final houseProvider = Provider.of<HouseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Houses')),
      body: houseProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : houseProvider.houses.isEmpty
          ? const Center(child: Text('No houses yet.'))
          : ListView.builder(
        itemCount: houseProvider.houses.length,
        itemBuilder: (context, index) {
          final house = houseProvider.houses[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(house.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type of housing: ${house.type}'),
                  Text('Size: ${house.size} m²'),
                  Text('Price: \$${house.price}'),
                  Text('Internet: ${house.internet}'),
                  Text('Status: ${house.isActive ? "Active" : "Inactive"}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(house.isActive ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => houseProvider.toggleHouseActive(house.id, house.isActive),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showHouseDialog(user.uid, house),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showHouseDialog(user.uid),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showHouseDialog(String ownerId, [House? house]) {
    final houseProvider = Provider.of<HouseProvider>(context, listen: false);

    final _titleController = TextEditingController(text: house?.title ?? '');
    final _typeController = TextEditingController(text: house?.type ?? '');
    final _sizeController = TextEditingController(text: house?.size.toString() ?? '');
    final _priceController = TextEditingController(text: house?.price.toString() ?? '');

    // Use dropdown values directly
    String _internet = house?.internet == true ? 'wifi' : 'none';

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
                  LabeledTextField(
                    label: 'Title',
                    controller: _titleController,
                    validator: (v) => v!.isEmpty ? 'Title is required' : null,
                  ),
                  LabeledTextField(
                    label: 'Type of housing',
                    controller: _typeController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Type is required';
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v)) return 'Only letters allowed';
                      return null;
                    },
                  ),
                  LabeledTextField(
                    label: 'Size (m²)',
                    controller: _sizeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Size is required';
                      if (!RegExp(r'^\d+$').hasMatch(v)) return 'Only numbers allowed';
                      return null;
                    },
                  ),
                  LabeledTextField(
                    label: 'Price (CHF)',
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Price is required';
                      if (!RegExp(r'^\d+$').hasMatch(v)) return 'Only numbers allowed';
                      return null;
                    },
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
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
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
                  ownerId: ownerId,
                  isActive: house?.isActive ?? true,
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
}
