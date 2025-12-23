import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/providers/favorites_provider.dart';
import '../../domain/repositories/business_repository.dart';
import '../../domain/entities/business.dart';
import '../../../../features/queue/presentation/pages/business_details_page.dart'; // To navigate to details
import '../../../home/data/models/business_model.dart'; // For casting if needed

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final BusinessRepository _businessRepository = GetIt.I<BusinessRepository>();

  Future<List<Business>> _loadFavorites(List<String> ids) async {
    final List<Business> businesses = [];
    for (final id in ids) {
      final result = await _businessRepository.getBusinessById(id);
      result.fold(
        (failure) => null, // Ignore failures for now
        (business) => businesses.add(business),
      );
    }
    return businesses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: Consumer<FavoritesProvider>(
        builder: (context, favorites, child) {
          if (favorites.favoriteIds.isEmpty) {
            return const Center(child: Text('لا توجد مفضلات حالياً'));
          }

          return FutureBuilder<List<Business>>(
            future: _loadFavorites(favorites.favoriteIds),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('لم يتم العثور على بيانات'));
              }

              final businesses = snapshot.data!;

              return ListView.builder(
                itemCount: businesses.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final business = businesses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: business.imageUrl.isNotEmpty
                            ? NetworkImage(business.imageUrl)
                            : null,
                        child: business.imageUrl.isEmpty
                            ? const Icon(Icons.store)
                            : null,
                      ),
                      title: Text(business.name),
                      subtitle: Text(business.category),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          favorites.toggleFavorite(business.id);
                          // The list will rebuild automatically due to Consumer
                        },
                      ),
                      onTap: () {
                        // Navigate to details
                        // Note: BusinessDetailsPage expects BusinessModel.
                        // If Business is not BusinessModel, we might need manual mapping or ensure Repo returns Models.
                        // Repo interface returns Business entity.
                        // Assuming BusinessModel is returned or we can Map.
                        // For now we assume compatibility or simple Cast if Impl returns Models.
                        if (business is BusinessModel) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BusinessDetailsPage(business: business),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
