import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_keys.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _language = "es";
  double _fontSize = 16;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool(PreferencesKeys.darkMode) ?? false;
      _language = prefs.getString(PreferencesKeys.language) ?? "es";
      _fontSize = prefs.getDouble(PreferencesKeys.fontSize) ?? 16;
    });
  }

  void savePreferences(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    String previewText = "¡Hola! Este es un texto de prueba para ver cómo luce el tamaño de fuente y el modo oscuro.";
    if (_language == "en") {
      previewText = "Hello! This is a preview text to see how the font size and dark mode look.";
    } else if (_language == "ch") {
      previewText = "你好！这是预览文本，用于查看字体大小和暗黑模式的外观。";
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                title: const Text(
                  "Modo oscuro",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                value: _darkMode,
                activeColor: const Color(0xFF6200EA),
                onChanged: (darkMode) {
                  setState(() => _darkMode = darkMode);
                  savePreferences(PreferencesKeys.darkMode, darkMode);
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _language,
                dropdownColor: const Color(0xFF16213E),
                items: const [
                  DropdownMenuItem(
                    value: "es",
                    child: Text("Español", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text("Inglés", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: "ch",
                    child: Text("Chino", style: TextStyle(color: Colors.white)),
                  )
                ],
                onChanged: (language) {
                  if (language != null) {
                    setState(() => _language = language);
                    savePreferences(PreferencesKeys.language, language);
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Idioma",
                  labelStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Tamaño de la fuente: ${_fontSize.toStringAsFixed(0)}",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Slider(
                min: 14,
                max: 24,
                value: _fontSize,
                activeColor: const Color(0xFF6200EA),
                inactiveColor: Colors.white24,
                onChanged: (fontSize) {
                  setState(() => _fontSize = fontSize);
                  savePreferences(PreferencesKeys.fontSize, fontSize);
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Vista Previa:",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: _darkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Text(
                previewText,
                style: TextStyle(
                  fontSize: _fontSize,
                  color: _darkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                "Nota: Esta pantalla es una demostración. Las preferencias se guardan de forma local pero no cambian el tema global de la app.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
