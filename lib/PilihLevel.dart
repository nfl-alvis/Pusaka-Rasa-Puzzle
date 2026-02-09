import 'package:flutter/material.dart';

class PilihLevel extends StatefulWidget {
  const PilihLevel({super.key});

  @override
  State<PilihLevel> createState() => _PilihLevelState();
}

class _PilihLevelState extends State<PilihLevel> {
  // List untuk menyimpan status level yang sudah dibuka
  final List<bool> _unlockedLevels = [true, true, true, false, false, false];

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
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

                const SizedBox(height: 20),

                // ===== LEVEL GRID =====
                Expanded(child: _buildLevelGrid(screenWidth)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // TOMBOL BACK
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Semantics(
              label: 'Tombol kembali',
              button: true,
              child: Image.asset(
                'assets/buttons/BtnKembali2.png',
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade600,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 26,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 16),

          // TITLE IMAGE
          Expanded(
            child: Semantics(
              label: 'Pilih Level',
              header: true,
              child: Image.asset(
                'assets/buttons/LogoPilihLevel.png',
                height: 65,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFFD54F), Color(0xFFFFA726)],
                      ),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Colors.brown.shade900,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Pilih Level',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.brown.shade900,
                          letterSpacing: 1,
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.5),
                              offset: const Offset(0, -1),
                              blurRadius: 2,
                            ),
                          ],
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

  Widget _buildLevelGrid(double screenWidth) {
    // Calculate optimal padding based on screen width
    final horizontalPadding = screenWidth * 0.08;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: screenWidth * 0.04,
          mainAxisSpacing: screenWidth * 0.04,
          childAspectRatio: 0.95,
        ),
        itemCount: _unlockedLevels.length,
        itemBuilder: (context, index) {
          return _buildLevelButton(index + 1, _unlockedLevels[index]);
        },
      ),
    );
  }

  Widget _buildLevelButton(int level, bool isUnlocked) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              // Navigate to game with selected level
              print('Level $level dipilih');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => GamePage(level: level))
              // );
            }
          : null,
      child: isUnlocked ? _buildUnlockedButton(level) : _buildLockedButton(),
    );
  }

  Widget _buildUnlockedButton(int level) {
    return Stack(
      children: [
        // Background Image - TombolAdvanture.png (sudah include puzzle piece)
        Image.asset(
          'assets/buttons/TombolAdvanture.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),

        // Angka Level di bagian bawah
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: Text(
              '$level',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Color(0xFF5D4037),
                    offset: const Offset(0, 3),
                    blurRadius: 4,
                  ),
                  Shadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLockedButton() {
    return Opacity(
      opacity: 0.8, // Transparansi 70%
      child: Image.asset(
        'assets/buttons/LogoTerkunci.png',
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          // Fallback jika gambar tidak ada
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6B7C8F),
                  Color(0xFF4A5A6D),
                  Color(0xFF3A4654),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Color(0xFF546E7A).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 56,
                  color: Color(0xFFCFD8DC),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
