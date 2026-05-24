import 'package:flutter/material.dart';
import 'package:movil/components/task_card.dart';
import 'Tarea 5/imc/screens/imc_home_screen.dart';
import 'Tarea 5/imc/core/app_colors.dart';
import 'Tarea 6/map_screen.dart';
import 'Tarea 7/screens/superhero_search_screen.dart';
import 'Tarea 9/settings_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tareas de Móvil',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Selecciona un proyecto para explorar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    TaskCard(
                      title: 'IMC Calculator',
                      subtitle: 'Tarea 5 - Salud y Saludable',
                      icon: Icons.monitor_weight_rounded,
                      gradient: const [Color(0xFF6200EA), Color(0xFF3700B3)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            backgroundColor: AppColors.background,
                            appBar: AppBar(
                              title: const Text('IMC Calculator'),
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            body: const ImcHomeScreen(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TaskCard(
                      title: 'Maps',
                      subtitle: 'Tarea 6 - Geolocalización',
                      icon: Icons.map_rounded,
                      gradient: const [Color(0xFF00C853), Color(0xFF1B5E20)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MapScreen()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TaskCard(
                      title: 'Superhero Search',
                      subtitle: 'Tarea 7 - API y Consultas',
                      icon: Icons.flash_on_rounded,
                      gradient: const [Color(0xFFD50000), Color(0xFFB71C1C)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SuperheroSearchScreen()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TaskCard(
                      title: 'Settings',
                      subtitle: 'Tarea 9 - Configuraciones (SharedPreferences)',
                      icon: Icons.settings_rounded,
                      gradient: const [Color(0xFF009688), Color(0xFF004D40)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
