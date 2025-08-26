import 'package:flutter/material.dart';

class EcoTravelScreen extends StatefulWidget {
  @override
  _EcoTravelScreenState createState() => _EcoTravelScreenState();
}

class _EcoTravelScreenState extends State<EcoTravelScreen> {
  final List<String> categories = ["All", "Transport", "Stay", "Destinations"];
  String selectedCategory = "All";

  final List<Map<String, dynamic>> travelTips = [
    // ===== TRANSPORT =====
    {
      "title": "Use Public Transport",
      "description": "Buses, trains, and trams reduce CO2 emissions.",
      "category": "Transport",
      "ecoScore": 9.5,
      // 
      "image": "assets/images/public_transport.jpg",
    },
    {
      "title": "Carpooling",
      "description": "Share rides with friends or colleagues to save fuel.",
      "category": "Transport",
      "ecoScore": 9.3,
      // 
      "image": "assets/images/carpooling.jpg",
    },
    {
      "title": "Cycling to Work",
      "description": "A healthy and zero-emission travel option.",
      "category": "Transport",
      "ecoScore": 9.8,
      // 
      "image": "assets/images/cycling.jpg",
    },
    {
      "title": "Electric Scooters",
      "description": "A fun and eco-friendly short-distance solution.",
      "category": "Transport",
      "ecoScore": 8.9,
      // 
      "image": "assets/images/e_scooter.jpg",
    },
    {
      "title": "Walking",
      "description": "Best for the environment and your health.",
      "category": "Transport",
      "ecoScore": 10.0,
      // 
      "image": "assets/images/walking.jpg",
    },

    // ===== STAY =====
    {
      "title": "Eco-friendly Hotels",
      "description": "Choose accommodations with green certifications.",
      "category": "Stay",
      "ecoScore": 9.0,
      // 
      "image": "assets/images/eco_hotel.jpg",
    },
    {
      "title": "Local Guesthouses",
      "description": "Support local communities and reduce emissions.",
      "category": "Stay",
      "ecoScore": 8.8,
      // 
      "image": "assets/images/guesthouse.jpg",
    },
    {
      "title": "Camping",
      "description": "Stay close to nature with minimal footprint.",
      "category": "Stay",
      "ecoScore": 9.4,
      // 
      "image": "assets/images/camping.jpg",
    },
    {
      "title": "Eco Resorts",
      "description": "Luxury with sustainability in mind.",
      "category": "Stay",
      "ecoScore": 9.2,
      // 
      "image": "assets/images/eco_resort.jpg",
    },
    {
      "title": "Hostels with Green Practices",
      "description": "Budget-friendly and environmentally conscious.",
      "category": "Stay",
      "ecoScore": 8.7,
      // 
      "image": "assets/images/green_hostel.jpg",
    },

    // ===== DESTINATIONS =====
    {
      "title": "Local Destinations",
      "description": "Explore nearby places to avoid long flights.",
      "category": "Destinations",
      "ecoScore": 8.7,
      // 
      "image": "assets/images/local_destination.jpg",
    },
    {
      "title": "National Parks",
      "description": "Reconnect with nature and support conservation.",
      "category": "Destinations",
      "ecoScore": 9.6,
      // 
      "image": "assets/images/national_park.jpg",
    },
    {
      "title": "Cultural Heritage Sites",
      "description": "Learn history while minimizing carbon footprint.",
      "category": "Destinations",
      "ecoScore": 9.1,
      // 
      "image": "assets/images/heritage_site.jpg",
    },
    {
      "title": "Wildlife Sanctuaries",
      "description": "Protect endangered species and ecosystems.",
      "category": "Destinations",
      "ecoScore": 9.4,
      // 
      "image": "assets/images/wildlife_sanctuary.jpg",
    },
    {
      "title": "Eco Villages",
      "description": "Experience sustainable community living.",
      "category": "Destinations",
      "ecoScore": 9.0,
      // 
      "image": "assets/images/eco_village.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(),
            SizedBox(height: 10),
            _buildCategoryChips(),
            SizedBox(height: 10),
            Expanded(child: _buildTravelTipsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/travel_banner.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(height: 180, color: Colors.black.withOpacity(0.3)),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            "Eco Travel Tips",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 5)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              selectedColor: Colors.green,
              backgroundColor: Colors.grey[300],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTravelTipsList() {
    final filteredTips = selectedCategory == "All"
        ? travelTips
        : travelTips.where((tip) => tip["category"] == selectedCategory).toList();

    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: filteredTips.length,
      itemBuilder: (context, index) {
        final tip = filteredTips[index];
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  tip["image"],
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        tip["title"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.eco, color: Colors.green, size: 16),
                          SizedBox(width: 4),
                          Text(
                            tip["ecoScore"].toString(),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(
                  tip["description"],
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
