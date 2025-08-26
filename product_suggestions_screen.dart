import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class ProductSuggestionsScreen extends StatelessWidget {
  final List<Map<String, String>> ecoProducts = [
    
        {
      'name': 'Reusable Water Bottle',
      'desc': 'Stay hydrated without single-use plastics.',
      'image': 'assets/images/resusable_water_bottle.jpg',
      'usage':
          'Fill the bottle with clean water and carry it with you daily. Clean regularly.',
    },
    {
      'name': 'Bamboo Toothbrush',
      'desc': 'Eco-friendly alternative to plastic toothbrushes.',
      'image': 'assets/images/toothbrush.jpg',
      'usage':
          'Use like a regular toothbrush. Replace every 3 months. Compost after use.',
    },
    {
      'name': 'Organic Tote Bag',
      'desc': 'Perfect for shopping without plastic bags.',
      'image': 'assets/images/totebag.jpg',
      'usage': 'Take it to groceries, malls, or markets. Wash occasionally.',
    },
    {
      'name': 'Solar Power Bank',
      'desc': 'Charge your devices using solar energy.',
      'image': 'assets/images/solarbank.jpg',
      'usage': 'Place under sunlight to charge, then use USB to power devices.',
    },
  ];

  ProductSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Eco-Friendly Products',
          style: TextStyle(color: Colors.white), // yahan color set kar diya
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: ecoProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            final product = ecoProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      name: product['name']!,
                      desc: product['desc']!,
                      image: product['image']!,
                      usage: product['usage']!,
                    ),
                  ),
                );
              },
              child: _buildProductCard(product),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Image.asset(
                product['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Text(
                  product['desc']!,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
