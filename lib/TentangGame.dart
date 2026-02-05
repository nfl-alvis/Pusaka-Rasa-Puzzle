import 'package:flutter/material.dart';

class TentangGame extends StatefulWidget {
  const TentangGame({super.key});

  @override
  State<TentangGame> createState() => _TentangGameState();
}

class _TentangGameState extends State<TentangGame> {
  bool _isLoading = true;

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
          const AssetImage('assets/images/Logo.png'),
          context,
        ), // Logo ditambahkan
        precacheImage(
          const AssetImage('assets/buttons/BtnKembali2.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/TentangGameLogo.png'),
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                color: Colors.blue.shade200,
                child: const Center(
                  child: Icon(Icons.error, size: 50, color: Colors.red),
                ),
              );
            },
          ),

          // Konten Utama
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(context),

                // Konten Scrollable
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Card Informasi Game
                        _buildInfoCard(context, screenWidth: screenWidth),
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
      label: 'Tentang Game',
      header: true,
      child: Image.asset(
        'assets/buttons/TentangGameLogo.png',
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
                'Tentang Game',
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

  Widget _buildInfoCard(BuildContext context, {required double screenWidth}) {
    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.shade300, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Game (DIGANTI DARI TEXT)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/Logo.png',
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    children: [
                      Text(
                        'Pusaka Rasa',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                      Text(
                        'Sliding Puzzle',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown.shade600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Divider
          Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 20),

          // Deskripsi
          _buildInfoSection(
            icon: Icons.info_outline,
            title: 'Deskripsi',
            content:
                'Pusaka Rasa Puzzle adalah game puzzle geser edukatif yang '
                'mengenalkan berbagai makanan tradisional Indonesia. '
                'Pecahkan puzzle untuk mempelajari kekayaan kuliner Nusantara!',
          ),
          const SizedBox(height: 20),

          // Cara Bermain
          _buildInfoSection(
            icon: Icons.gamepad_outlined,
            title: 'Cara Bermain',
            content:
                '1. Pilih level kesulitan\n'
                '2. Geser potongan puzzle untuk menyusun gambar\n'
                '3. Selesaikan puzzle untuk membuka informasi makanan\n'
                '4. Pelajari tentang makanan tradisional Indonesia',
          ),
          const SizedBox(height: 20),

          // Tujuan
          _buildInfoSection(
            icon: Icons.flag_outlined,
            title: 'Tujuan',
            content:
                'Mengenalkan dan melestarikan budaya kuliner Indonesia '
                'melalui permainan yang menyenangkan dan edukatif.',
          ),
          const SizedBox(height: 20),

          // Fitur
          _buildInfoSection(
            icon: Icons.star_outline,
            title: 'Fitur',
            content:
                '• Berbagai level kesulitan\n'
                '• Galeri makanan tradisional\n'
                '• Informasi lengkap setiap makanan\n'
                '• Antarmuka yang menarik dan ramah anak',
          ),
          const SizedBox(height: 24),

          // Divider
          Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 16),

          // Copyright
          Center(
            child: Text(
              '© 2026 Pusaka Rasa Puzzle',
              style: TextStyle(
                fontSize: 12,
                color: Colors.brown.shade400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Center(
            child: Text(
              'Dikembangkan dengan ❤️ untuk Indonesia',
              style: TextStyle(
                fontSize: 12,
                color: Colors.brown.shade400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.orange.shade700, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.brown.shade700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
