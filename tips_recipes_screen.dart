import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TipsRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Energy Conservation Tips',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('- Turn off lights when not in use'),
        Text('- Use energy-efficient bulbs'),
        Text('- Optimize heating and cooling systems'),
        // more tips...

        SizedBox(height: 24),

        Text(
          'Sustainable Recipes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('- Veggie Stir-Fry'),
        Text('- Lentil Soup'),
        Text('- Quinoa Salad with Local Veggies'),
        // more recipes...
      ],
    );
  }
}
