import 'package:flutter/material.dart';

class CaraBermain extends StatefulWidget {
  const CaraBermain({super.key});

  @override
  State<CaraBermain> createState() => _CaraBermainState();
}

class _CaraBermainState extends State<CaraBermain> {
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
          const AssetImage('assets/buttons/BtnKembali2.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/CaraBermainLogo.png'),
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
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

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                const SizedBox(height: 20),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildContent(screenWidth),
                  ),
                ),
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
          // Back Button
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

          // Title Logo
          // Expanded(
          //   child: Semantics(
          //     label: 'Cara Bermain',
          //     header: true,
          //     child: Image.asset(
          //       'assets/buttons/CaraBermainLogo.png',
          //       height: 60,
          //       fit: BoxFit.contain,
          //       errorBuilder: (context, error, stackTrace) {
          //         return Container(
          //           height: 60,
          //           decoration: BoxDecoration(
          //             color: Colors.orange.shade200,
          //             borderRadius: BorderRadius.circular(30),
          //             border: Border.all(
          //               color: Colors.brown.shade800,
          //               width: 3,
          //             ),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.black.withOpacity(0.15),
          //                 blurRadius: 6,
          //                 offset: const Offset(0, 3),
          //               ),
          //             ],
          //           ),
          //           child: const Center(
          //             child: Text(
          //               'Cara Bermain',
          //               style: TextStyle(
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.brown,
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildContent(double screenWidth) {
    return Column(
      children: [
        _buildInfoCard(screenWidth),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoCard(double screenWidth) {
    return Container(
      width: screenWidth * 0.95,
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
          // Title
          // Center(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [Colors.orange.shade400, Colors.orange.shade600],
          //       ),
          //       borderRadius: BorderRadius.circular(25),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.orange.withOpacity(0.3),
          //           blurRadius: 8,
          //           offset: const Offset(0, 3),
          //         ),
          //       ],
          //     ),
          //     child: const Text(
          //       '🎮 Panduan Bermain Puzzle',
          //       style: TextStyle(
          //         fontSize: 22,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 24),

          // Step 1
          _buildStepCard(
            stepNumber: '1',
            title: 'Pilih Level',
            description:
                'Pilih level kesulitan yang sesuai dengan kemampuan Anda. Mulai dari level mudah hingga level sulit.',
            icon: Icons.grid_view,
            color: Colors.blue,
          ),

          const SizedBox(height: 16),

          // Step 2
          _buildStepCard(
            stepNumber: '2',
            title: 'Geser Potongan Puzzle',
            description:
                'Ketuk potongan puzzle yang berdekatan dengan kotak kosong untuk menggesernya. Susun gambar hingga sempurna!',
            icon: Icons.touch_app,
            color: Colors.green,
          ),

          const SizedBox(height: 16),

          // Step 3
          _buildStepCard(
            stepNumber: '3',
            title: 'Gunakan Fitur Bantuan',
            description:
                'Gunakan tombol Hint untuk melihat gambar asli, atau Reset untuk mengacak ulang puzzle.',
            icon: Icons.help_outline,
            color: Colors.orange,
          ),

          const SizedBox(height: 16),

          // Step 4
          _buildStepCard(
            stepNumber: '4',
            title: 'Selesaikan Puzzle',
            description:
                'Susun semua potongan dengan urutan yang benar untuk menyelesaikan puzzle dan membuka informasi makanan!',
            icon: Icons.check_circle,
            color: Colors.purple,
          ),

          const SizedBox(height: 24),

          // Divider
          Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 20),

          // Kontrol Game
          _buildControlSection(),

          const SizedBox(height: 20),
          Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 20),

          // Tips Dasar
          _buildTipsSection(),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required String stepNumber,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number Circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.brown.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gamepad, color: Colors.orange.shade700, size: 24),
            const SizedBox(width: 8),
            Text(
              'Kontrol Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildControlItem(
          icon: Icons.touch_app,
          label: 'Ketuk Puzzle',
          description: 'Geser potongan puzzle',
        ),
        _buildControlItem(
          icon: Icons.pause,
          label: 'Pause',
          description: 'Jeda permainan',
        ),
        _buildControlItem(
          icon: Icons.lightbulb_outline,
          label: 'Hint',
          description: 'Lihat gambar asli',
        ),
        _buildControlItem(
          icon: Icons.refresh,
          label: 'Reset',
          description: 'Acak ulang puzzle',
        ),
      ],
    );
  }

  Widget _buildControlItem({
    required IconData icon,
    required String label,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 32),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.orange.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade800,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tips_and_updates, color: Colors.orange.shade700, size: 24),
            const SizedBox(width: 8),
            Text(
              'Tips Bermain',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTipItem('Mulai dari sudut atau tepi gambar'),
        _buildTipItem('Perhatikan pola dan warna gambar'),
        _buildTipItem('Gunakan hint jika kesulitan'),
        _buildTipItem('Latih kemampuan dengan bermain rutin'),
        _buildTipItem('Tantang waktu terbaik Anda!'),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 15,
                color: Colors.brown.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}