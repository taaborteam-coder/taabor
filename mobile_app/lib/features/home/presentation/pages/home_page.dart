import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../domain/entities/business.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../../../queue/presentation/pages/business_details_page.dart';
import '../../../queue/presentation/pages/history_page.dart';
import 'map_page.dart';
import '../../../merchant/presentation/pages/merchant_dashboard_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BusinessBloc>()..add(GetBusinessesEvent()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحلات القريبة'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryPage()),
              );
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          BlocBuilder<BusinessBloc, BusinessState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is BusinessesLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapPage(businesses: state.businesses),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.location_on_outlined),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MerchantDashboardPage(
                    businessId: 'test_business',
                    businessName: 'متجري',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.storefront),
            tooltip: 'لوحة التاجر',
          ),
        ],
      ),
      body: BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state is BusinessLoading) {
            return _buildShimmerLoading();
          }
          if (state is BusinessError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          if (state is BusinessesLoaded) {
            final businesses = state.businesses;
            if (businesses.isEmpty) {
              return const Center(child: Text('لا توجد محلات قريبة'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: businesses.length,
              itemBuilder: (context, index) {
                final business = businesses[index];
                return _BusinessCard(business: business);
              },
            );
          }
          return const Center(child: Text('لا توجد بيانات'));
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _BusinessCard extends StatelessWidget {
  final Business business;

  const _BusinessCard({required this.business});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BusinessDetailsPage(
                business:
                    business
                        as dynamic, // Cast since BusinessDetailsPage expects BusinessModel
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[300],
              child: Hero(
                tag: 'business_image_${business.id}',
                child: business.imageUrl.isNotEmpty
                    ? Image.network(
                        business.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.store,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.store, size: 50, color: Colors.grey),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          business.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: business.isOpen
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          business.isOpen ? 'مفتوح' : 'مغلق',
                          style: TextStyle(
                            color: business.isOpen
                                ? Colors.green[800]
                                : Colors.red[800],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    business.category,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'انتظار: ${business.estimatedWaitTimeMinutes} دقيقة',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.star, size: 16, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text('${business.rating}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
