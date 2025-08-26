import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarbonTrackerScreen extends StatefulWidget {
  const CarbonTrackerScreen({super.key});

  @override
  _CarbonTrackerScreenState createState() => _CarbonTrackerScreenState();
}

class _CarbonTrackerScreenState extends State<CarbonTrackerScreen> {
  final distanceController = TextEditingController();
  final electricityController = TextEditingController();
  final carbonOffsetController = TextEditingController();  // Controller renamed for clarity
  double? result;

  void _calculate() async {
    final double distance = double.tryParse(distanceController.text) ?? 0;
    final double electricity = double.tryParse(electricityController.text) ?? 0;
    final double carbonOffset = double.tryParse(carbonOffsetController.text) ?? 0;

    // CO₂ calculation logic updated to use carbonOffset instead of meals
    double co2 = (distance * 0.21) + (electricity * 0.5) - carbonOffset;

    final prefs = await SharedPreferences.getInstance();

    // Save latest CO₂ value
    await prefs.setDouble('latest_co2_saved', co2);

    // Add to total CO₂ saved
    double currentTotal = prefs.getDouble('total_co2_saved') ?? 0.0;
    await prefs.setDouble('total_co2_saved', currentTotal + co2);

    setState(() {
      result = co2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🌱 Carbon Footprint Tracker",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                _buildInputCard(
                  title: "Distance Travelled (km)",
                  icon: Icons.directions_car,
                  controller: distanceController,
                  hint: "e.g. 12.5",
                ),
                _buildInputCard(
                  title: "Electricity Used (kWh)",
                  icon: Icons.flash_on,
                  controller: electricityController,
                  hint: "e.g. 8.0",
                ),
                _buildInputCard(
                  title: "Carbon Offset (kg)",
                  icon: Icons.eco,
                  controller: carbonOffsetController,
                  hint: "e.g. 5",
                ),

                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Calculate Footprint",
                      style: TextStyle(color: Colors.white),  // Button text white
                    ),
                  ),
                ),

                SizedBox(height: 30),
                if (result != null) _buildResultCard(),

                SizedBox(height: 30),
                Text(
                  "💡 Tips to Reduce Footprint",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _tipsCard("Turn off appliances when not in use."),
                _tipsCard("Use public transport or carpool."),
                _tipsCard("Try a vegetarian meal once a day."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    required String hint,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: title,
                  hintText: hint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            "Your Estimated CO₂ Footprint",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "${result!.toStringAsFixed(2)} kg CO₂e",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipsCard(String tip) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green),
          SizedBox(width: 12),
          Expanded(child: Text(tip)),
        ],
      ),
    );
  }
}
