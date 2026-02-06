import 'package:flutter/material.dart';

class Panduan extends StatefulWidget {
  const Panduan({super.key});

  @override
  State<Panduan> createState() => _PanduanState();
}

class _PanduanState extends State<Panduan> {
  bool _isLoading = true;
  int? _expandedIndex; // Track which section is expanded

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    try {
      await Future.wait([
        precacheImage(const AssetImage('assets/images/Bg.jpg'), context),
        precacheImage(
          const AssetImage('assets/buttons/BtnKembali2.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/PanduanLogo.png'),
          context,
        ),
      ]);

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Error loading images: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Tombol Kembali
          _buildBackButton(context),
          const SizedBox(width: 14),

          // Title Logo
          Expanded(child: _buildTitleLogo()),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Material(
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
    );
  }

  Widget _buildTitleLogo() {
    return Semantics(
      label: 'Panduan',
      header: true,
      child: Image.asset(
        'assets/buttons/PanduanLogo.png',
        height: 60,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.brown.shade800, width: 3),
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
                'Panduan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // Close if already open
      } else {
        _expandedIndex = index; // Open new section
      }
    });
  }

  Widget _buildGuideCard({
    required int index,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isExpanded = _expandedIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        // Gradient kayu coklat
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD4A574), // Coklat kayu terang
            const Color(0xFFB8895C), // Coklat kayu medium
            const Color(0xFFA67C52), // Coklat kayu gelap
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF8B6F47), // Border coklat tua
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade900.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleExpansion(index),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Icon dengan background putih transparan
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.brown.shade900,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Title
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Expand/Collapse Icon
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.brown.shade900,
                      size: 28,
                    ),
                  ],
                ),

                // Expandable Description
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.brown.shade900,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Image.asset(
            'assets/images/Bg.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.blue.shade200,
                child: const Center(
                  child: Icon(Icons.error, size: 50, color: Colors.red),
                ),
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(context),

                // Guide Cards
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        // 1. Memulai Permainan
                        _buildGuideCard(
                          index: 0,
                          icon: Icons.grid_3x3,
                          title: '1. Memulai Permainan',
                          description:
                              'Pilih Gambar: Jelajahi galeri gambar makanan khas Indonesia yang lezat. Ketuk gambar yang paling mengugah selera Anda untuk dijadikan puzzle.',
                        ),

                        // 2. Menyusun Puzzle
                        _buildGuideCard(
                          index: 1,
                          icon: Icons.extension,
                          title: '2. Menyusun Puzzle',
                          description:
                              'Geser Potongan: Gunakan jari Anda untuk menggeser potongan puzzle. Susun kembali gambar makanan hingga sempurna. Semakin cepat Anda menyelesaikan, semakin tinggi skor Anda!',
                        ),

                        // 3. Gunakan Bantuan
                        _buildGuideCard(
                          index: 2,
                          icon: Icons.lightbulb_outline,
                          title: '3. Gunakan Bantuan',
                          description:
                              'Tombol Bantuan: Jika Anda merasa kesulitan, gunakan tombol bantuan untuk melihat pratinjau gambar asli. Fitur ini akan membantu Anda menyelesaikan puzzle dengan lebih mudah.',
                        ),

                        // 4. Tujuan & Skor
                        _buildGuideCard(
                          index: 3,
                          icon: Icons.emoji_events,
                          title: '4. Tujuan & Skor',
                          description:
                              'Selesaikan Puzzle: Tujuan utama adalah menyusun puzzle hingga sempurna. Raih skor tertinggi dengan menyelesaikan puzzle secepat mungkin dengan jumlah gerakan minimum!',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}