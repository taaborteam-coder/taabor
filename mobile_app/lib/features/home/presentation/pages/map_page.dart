import 'package:flutter/material.dart';
import '../../domain/entities/business.dart';

class MapPage extends StatelessWidget {
  final List<Business> businesses;

  const MapPage({super.key, required this.businesses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الخريطة')),
      body: Stack(
        children: [
          // Mock Map Background
          Container(
            color: Colors.blue[50], // Water-like color
            child: Stack(
              children: [
                // Roads/Grid
                Column(
                  children: List.generate(
                    10,
                    (index) => const Divider(
                      height: 60,
                      thickness: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    10,
                    (index) => const VerticalDivider(
                      width: 60,
                      thickness: 10,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Pins
                ...businesses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final business = entry.value;
                  // Pseudo-random position
                  final top = 100.0 + (index * 150) % 400;
                  final left = 50.0 + (index * 80) % 300;

                  return Positioned(
                    top: top,
                    left: left,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(blurRadius: 4, color: Colors.black26),
                            ],
                          ),
                          child: Text(
                            business.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Bottom Info
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black12),
                ],
              ),
              child: const Text(
                'ملاحظة: هذه خريطة تجريبية. سيتم دمج Google Maps في الإصدار النهائي.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
