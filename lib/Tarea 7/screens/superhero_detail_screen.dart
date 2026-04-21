import 'package:flutter/material.dart';
import '../data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                superhero.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    superhero.url,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.4),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xFF0F0F0F)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (superhero.realName.isNotEmpty) ...[
                    const Text(
                      "REAL NAME",
                      style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 2),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      superhero.realName,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 32),
                  ],
                  const Text(
                    "POWER STATS",
                    style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 2),
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow("Intelligence", superhero.powerStatsResponse.intelligence, Colors.blue),
                  _buildStatRow("Strength", superhero.powerStatsResponse.strength, Colors.red),
                  _buildStatRow("Speed", superhero.powerStatsResponse.speed, Colors.amber),
                  _buildStatRow("Durability", superhero.powerStatsResponse.durability, Colors.green),
                  _buildStatRow("Power", superhero.powerStatsResponse.power, Colors.purple),
                  _buildStatRow("Combat", superhero.powerStatsResponse.combat, Colors.orange),
                  const SizedBox(height: 100), // Spacing at bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    double percent = (double.tryParse(value) ?? 0) / 100;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70)),
              Text("${(percent * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
