import 'package:flutter/material.dart';

class PilihLevel extends StatefulWidget {
  const PilihLevel({super.key});

  @override
  State<PilihLevel> createState() => _PilihLevelState();
}

class _PilihLevelState extends State<PilihLevel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(  
            'assets/images/Bg.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.brown.shade700, Colors.brown.shade900],
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                // ===== HEADER =====
                _buildHeader(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // TOMBOL BACK
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(25),
              child: Semantics(
                label: 'Tombol kembali',
                button: true,
                child: Image.asset(
                  'assets/buttons/BtnKembali2.png',
                  width: 45,
                  height: 45,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade400,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // TITLE IMAGE
          Expanded(
            child: Semantics(
              label: 'Pilh Level',
              header: true,
              child: Image.asset(
                'assets/buttons/LogoPilihLevel.png',
                height: 60,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.brown.shade800,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Galeri Makanan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontFamily:
                              'Arial', // Bisa diganti dengan custom font
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),    
    );
  }
}
