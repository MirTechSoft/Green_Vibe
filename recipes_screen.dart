import 'package:flutter/material.dart';
import 'package:sustainable_living_app/screens/recipe_detail_screen.dart';

class RecipesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {
      'title': 'Vegan Stir Fry',
      'description': 'Fresh veggies and tofu in a soy-ginger sauce.',
      'image': 'assets/images/vengan_stir_fry.jpg',
      'tag': 'Vegan',
      'ingredients': [
        "1 cup broccoli florets",
        "1 cup bell peppers",
        "150g tofu",
        "2 tbsp soy sauce",
        "1 tsp ginger paste"
      ],
      'steps': [
        "Chop all vegetables and tofu",
        "Heat oil and add ginger paste",
        "Stir fry vegetables for 5 mins",
        "Add tofu and soy sauce, cook 3 mins"
      ],
      'extraText': 'A delicious and healthy vegan meal to enjoy any day.'
    },
    {
      'title': 'Local Lentil Soup',
      'description': 'Comforting soup made with local organic lentils.',
      'image': 'assets/images/local_lentil_soup.jpg',
      'tag': 'Local',
      'ingredients': [
        "1 cup red lentils",
        "1 onion, chopped",
        "2 cloves garlic",
        "4 cups vegetable broth",
        "1 tsp cumin"
      ],
      'steps': [
        "Rinse lentils and chop vegetables",
        "Sauté onion and garlic for 2 mins",
        "Add lentils, broth, and cumin",
        "Simmer for 20 mins until soft"
      ],
      'extraText': 'Warm your soul with this comforting lentil soup.'
    },
    {
      'title': 'Zero-Waste Salad',
      'description': 'Salad using leftover greens with tangy vinaigrette.',
      'image': 'assets/images/zero_waste_salad.jpg',
      'tag': 'Zero-Waste',
      'ingredients': [
        "2 cups leftover greens",
        "1 tomato, chopped",
        "2 tbsp vinaigrette",
        "Salt & pepper"
      ],
      'steps': [
        "Wash and chop vegetables",
        "Mix with vinaigrette",
        "Season with salt & pepper",
        "Serve fresh"
      ],
      'extraText': 'Use your leftovers creatively with this zero-waste salad.'
    },
    {
      'title': 'Quinoa & Veggie Bowl',
      'description': 'Protein-packed quinoa with fresh seasonal veggies.',
      'image': 'assets/images/quinoa_veggie_bowl.jpg',
      'tag': 'Healthy',
      'ingredients': [
        "1 cup cooked quinoa",
        "1/2 cup cherry tomatoes",
        "1/2 cup cucumber slices",
        "1/4 cup feta cheese",
        "2 tbsp olive oil"
      ],
      'steps': [
        "Cook quinoa as per instructions",
        "Chop vegetables",
        "Mix quinoa and veggies",
        "Drizzle olive oil and top with feta"
      ],
      'extraText': 'A nutritious bowl perfect for lunch or dinner.'
    },
    {
      'title': 'Chickpea Curry',
      'description': 'Spicy and flavorful curry with chickpeas and tomatoes.',
      'image': 'assets/images/chickpea_curry.jpg',
      'tag': 'Spicy',
      'ingredients': [
        "1 can chickpeas",
        "1 onion, chopped",
        "2 tomatoes, pureed",
        "1 tbsp curry powder",
        "1 cup coconut milk"
      ],
      'steps': [
        "Sauté onions until golden",
        "Add tomatoes and curry powder",
        "Stir in chickpeas and coconut milk",
        "Simmer for 15 minutes"
      ],
      'extraText': 'Rich and spicy curry to delight your taste buds.'
    },
    {
      'title': 'Homemade Granola',
      'description': 'Crunchy and healthy granola with nuts and honey.',
      'image': 'assets/images/homemade_granola.jpg',
      'tag': 'Breakfast',
      'ingredients': [
        "2 cups rolled oats",
        "1/2 cup mixed nuts",
        "1/4 cup honey",
        "1/4 cup coconut oil",
        "1 tsp cinnamon"
      ],
      'steps': [
        "Mix oats, nuts, and cinnamon",
        "Warm honey and coconut oil",
        "Combine all ingredients",
        "Bake at 350°F for 20 mins"
      ],
      'extraText': 'Start your day with this crunchy homemade granola.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // 🌿 Premium Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.restaurant_menu, size: 30, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Sustainable Recipes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // 📜 Recipes List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return _recipeCard(recipe, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeCard(Map<String, dynamic> recipe, BuildContext context) {
    final imageUrl = recipe['image'] ?? '';
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(
              title: recipe['title'] ?? 'No Title',
              description: recipe['description'] ?? '',
              imageUrl: imageUrl,
              ingredients: List<String>.from(recipe['ingredients'] ?? []),
              steps: List<String>.from(recipe['steps'] ?? []),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image(
                    image: imageUrl.isNotEmpty && imageUrl.startsWith('assets/')
                        ? AssetImage(imageUrl) as ImageProvider
                        : NetworkImage(imageUrl),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image,
                            color: Colors.grey, size: 50),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe['title'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // 📝 Description & Tags & Extra Text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['description'] ?? '',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (recipe['extraText'] != null &&
                      recipe['extraText']!.isNotEmpty)
                    Text(
                      recipe['extraText'] ?? '',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (recipe['tag'] != null && recipe['tag']!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recipe['tag'] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
