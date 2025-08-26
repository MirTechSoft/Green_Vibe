import 'package:flutter/material.dart';

class WasteTrackerScreen extends StatefulWidget {
  const WasteTrackerScreen({super.key});

  @override
  _WasteTrackerScreenState createState() => _WasteTrackerScreenState();
}

class _WasteTrackerScreenState extends State<WasteTrackerScreen> {
  final plasticController = TextEditingController();
  final recycleController = TextEditingController();
  final compostController = TextEditingController();

  final FocusNode plasticFocus = FocusNode();
  final FocusNode recycleFocus = FocusNode();
  final FocusNode compostFocus = FocusNode();

  double? totalPoints;

  void _calculateWasteImpact() {
    final int plastic = int.tryParse(plasticController.text) ?? 0;
    final int recycled = int.tryParse(recycleController.text) ?? 0;
    final int composted = int.tryParse(compostController.text) ?? 0;

    double points = (recycled * 1.5) + (composted * 2) - (plastic * 1);

    setState(() {
      totalPoints = points;
    });
  }

  @override
  void dispose() {
    plasticController.dispose();
    recycleController.dispose();
    compostController.dispose();
    plasticFocus.dispose();
    recycleFocus.dispose();
    compostFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 👈 tap caught on empty areas
      onTap: () {
        FocusScope.of(context).unfocus(); // 👈 hide keyboard
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ],
          ),
        ),
        onDrawerChanged: (isOpened) {
          if (isOpened) {
            FocusScope.of(context).unfocus(); // hide on drawer open
            plasticFocus.unfocus();
            recycleFocus.unfocus();
            compostFocus.unfocus();
          }
        },
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "♻️ Waste Reduction Tracker",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _inputCard(
                  title: "Plastic Items Used",
                  hint: "e.g. 3",
                  controller: plasticController,
                  icon: Icons.delete,
                  focusNode: plasticFocus,
                ),
                _inputCard(
                  title: "Items Recycled",
                  hint: "e.g. 5",
                  controller: recycleController,
                  icon: Icons.recycling,
                  focusNode: recycleFocus,
                ),
                _inputCard(
                  title: "Composted Items",
                  hint: "e.g. 2",
                  controller: compostController,
                  icon: Icons.grass,
                  focusNode: compostFocus,
                ),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: _calculateWasteImpact,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Calculate Impact",
                      style: TextStyle(color: Colors.white),  // <-- Text color white here
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                if (totalPoints != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        const Text("Your Waste Reduction Score", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(
                          "${totalPoints!.toStringAsFixed(1)} points",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                const Text(
                  "🌍 Tips for Waste Reduction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _tipsCard("Avoid plastic bottles and bags."),
                _tipsCard("Compost food scraps."),
                _tipsCard("Separate recyclables at home."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputCard({
    required String title,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required FocusNode focusNode,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                keyboardType: TextInputType.number,
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

  Widget _tipsCard(String tip) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(tip)),
        ],
      ),
    );
  }
}
