import 'package:flutter/material.dart';
import 'package:taabor/core/services/offer_service.dart';
import 'package:taabor/features/engagement/domain/entities/offer.dart';
import 'package:taabor/features/engagement/data/models/offer.dart'
    as offer_model;

class ManageOffersPage extends StatefulWidget {
  final String businessId;

  const ManageOffersPage({super.key, required this.businessId});

  @override
  State<ManageOffersPage> createState() => _ManageOffersPageState();
}

class _ManageOffersPageState extends State<ManageOffersPage> {
  final OfferService _offerService = OfferService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Offers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddOfferDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<List<Offer>>(
        stream: _offerService.getAllOffers(widget.businessId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final offers = snapshot.data ?? [];

          if (offers.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text('No offers created yet', style: TextStyle(fontSize: 16)),
                  Text(
                    'Tap + to create your first offer',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return _buildOfferTile(offer);
            },
          );
        },
      ),
    );
  }

  Widget _buildOfferTile(Offer offer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          offer.isActive ? Icons.check_circle : Icons.cancel,
          color: offer.isActive ? Colors.green : Colors.grey,
        ),
        title: Text(offer.title),
        subtitle: Text(
          '${offer.discountValue.toInt()}% - ${offer.description}',
        ),
        trailing: Switch(
          value: offer.isActive,
          onChanged: (val) {
            _offerService.updateOfferStatus(offer.id, val);
          },
        ),
      ),
    );
  }

  void _showAddOfferDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final discountController = TextEditingController();
    String discountType = 'percentage';
    DateTime validFrom = DateTime.now();
    DateTime validTo = DateTime.now().add(const Duration(days: 30));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create New Offer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: discountController,
                  decoration: const InputDecoration(
                    labelText: 'Discount Value',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: discountType,
                  decoration: const InputDecoration(labelText: 'Discount Type'),
                  items: const [
                    DropdownMenuItem(
                      value: 'percentage',
                      child: Text('Percentage'),
                    ),
                    DropdownMenuItem(
                      value: 'fixed',
                      child: Text('Fixed Amount'),
                    ),
                    DropdownMenuItem(
                      value: 'freebie',
                      child: Text('Free Item'),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      discountType = val!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text('Valid from: ${validFrom.toString().split(' ')[0]}'),
                Text('Valid to: ${validTo.toString().split(' ')[0]}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Convert string to enum
                final discountTypeEnum = discountType == 'percentage'
                    ? DiscountType.percentage
                    : discountType == 'fixed'
                    ? DiscountType.fixed
                    : DiscountType.freebie;

                final offer = offer_model.OfferModel(
                  id: '',
                  businessId: widget.businessId,
                  title: titleController.text.trim(),
                  description: descController.text.trim(),
                  discountType: discountTypeEnum,
                  discountValue:
                      double.tryParse(discountController.text) ?? 0.0,
                  validFrom: validFrom,
                  validTo: validTo,
                  isActive: true,
                );
                _offerService.addOffer(offer);
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
