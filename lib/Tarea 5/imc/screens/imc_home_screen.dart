import 'package:flutter/material.dart';
import '../components/gender_selector.dart';
import '../components/height_selector.dart';
import '../components/number_selector.dart';
import '../core/app_colors.dart';
import '../core/text_styles.dart';
import 'imc_result_screen.dart';

class ImcHomeScreen extends StatefulWidget {
  const ImcHomeScreen({super.key});

  @override
  State<ImcHomeScreen> createState() => _ImcHomeScreenState();
}

class _ImcHomeScreenState extends State<ImcHomeScreen> {
  int selectedAge = 20;
  int selectedWeight = 80;
  double selectedHeight = 160;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: Column(
        children: [
          const GenderSelector(),
          HeightSelector(
            selectedHeight: selectedHeight,
            onHeightChange: (newHeight) {
              setState(() {
                selectedHeight = newHeight;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: NumberSelector(
                    title: "PESO",
                    value: selectedWeight,
                    onDecrement: () => setState(() => selectedWeight--),
                    onIncrement: () => setState(() => selectedWeight++),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberSelector(
                    title: "EDAD",
                    value: selectedAge,
                    onDecrement: () => setState(() => selectedAge--),
                    onIncrement: () => setState(() => selectedAge++),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImcResultScreen(
                        height: selectedHeight,
                        weight: selectedWeight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  "CALCULAR RESULTADO",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
