import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/text_styles.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _GenderCard(
            title: "HOMBRE",
            imagePath: "assets/images/male.png",
            isSelected: selectedGender == "Hombre",
            onTap: () => setState(() => selectedGender = "Hombre"),
          ),
          const SizedBox(width: 16),
          _GenderCard(
            title: "MUJER",
            imagePath: "assets/images/female.png",
            isSelected: selectedGender == "Mujer",
            onTap: () => setState(() => selectedGender = "Mujer"),
          ),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.backgroundComponentSelected : AppColors.backgroundComponent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ] : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset(imagePath, height: 90, opacity: isSelected ? null : const AlwaysStoppedAnimation(0.5)),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyles.bodyText.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.white60,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
