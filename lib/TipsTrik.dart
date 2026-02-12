import 'package:flutter/material.dart';

class TipsTrik extends StatefulWidget {
  const TipsTrik({super.key});

  @override
  State<TipsTrik> createState() => _TipsTrikState();
}

class _TipsTrikState extends State<TipsTrik> {
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
                // Header dengan Back Button saja
                _buildHeader(),

                const SizedBox(height: 12),

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
    // Gabungkan semua tips menjadi satu list
    final allTips = [
      TipItem(
        title: 'Mulai dari Sudut',
        description:
            'Fokuskan perhatian pada potongan puzzle di sudut terlebih dahulu. Ini akan memberikan referensi yang jelas untuk menyusun bagian lainnya.',
        icon: Icons.crop_square,
        color: Colors.green,
      ),
      TipItem(
        title: 'Susun Tepi Terlebih Dahulu',
        description:
            'Susun bagian tepi puzzle untuk membuat kerangka. Ini akan memudahkan Anda menyusun bagian tengah.',
        icon: Icons.border_outer,
        color: Colors.green,
      ),
      TipItem(
        title: 'Kenali Pola Warna',
        description:
            'Perhatikan pola warna pada gambar makanan. Ini akan membantu Anda mengenali posisi yang tepat untuk setiap potongan.',
        icon: Icons.palette,
        color: Colors.green,
      ),
      TipItem(
        title: 'Jangan Terburu-buru',
        description:
            'Ambil waktu Anda untuk mengamati setiap potongan. Terkadang solusi terbaik datang saat Anda tenang dan fokus.',
        icon: Icons.schedule,
        color: Colors.green,
      ),
      TipItem(
        title: 'Visualisasi Gambar Lengkap',
        description:
            'Cobalah untuk mengingat atau membayangkan gambar lengkap sebelum bermain. Ini akan meningkatkan kecepatan Anda.',
        icon: Icons.visibility,
        color: Colors.blue,
      ),
      TipItem(
        title: 'Latih Pergerakan Minimal',
        description:
            'Usahakan untuk menyelesaikan puzzle dengan pergerakan seminimal mungkin. Ini akan melatih efisiensi berpikir Anda.',
        icon: Icons.trending_down,
        color: Colors.blue,
      ),
      TipItem(
        title: 'Tantang Waktu',
        description:
            'Setelah mahir, coba untuk mengalahkan rekor waktu Anda sendiri. Ini akan meningkatkan kecepatan dan ketepatan.',
        icon: Icons.timer,
        color: Colors.blue,
      ),
      TipItem(
        title: 'Mainkan Level yang Sama',
        description:
            'Bermain level yang sama berkali-kali akan membantu Anda menghafal pola dan meningkatkan performa.',
        icon: Icons.repeat,
        color: Colors.blue,
      ),
      TipItem(
        title: 'Teknik Segmentasi',
        description:
            'Bagi puzzle menjadi 3x3 segmen dalam pikiran Anda. Selesaikan satu segmen sebelum pindah ke segmen lain.',
        icon: Icons.grid_on,
        color: Colors.orange,
      ),
      TipItem(
        title: 'Perhatikan Detail Makanan',
        description:
            'Setiap makanan memiliki detail unik seperti tekstur nasi, warna saus, atau tata letak garnish. Gunakan ini sebagai petunjuk.',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      TipItem(
        title: 'Manfaatkan Hint Bijak',
        description:
            'Gunakan fitur hint hanya saat benar-benar stuck. Cobalah dulu tanpa hint untuk melatih kemampuan.',
        icon: Icons.lightbulb,
        color: Colors.orange,
      ),
      TipItem(
        title: 'Reset untuk Latihan',
        description:
            'Jangan ragu untuk reset puzzle jika Anda merasa ada cara yang lebih efisien. Ini bagus untuk pembelajaran.',
        icon: Icons.refresh,
        color: Colors.orange,
      ),
    ];

    return Container(
      width: screenWidth * 0.95,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
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
          // Tips List tanpa kategori title
          ...allTips.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildTipCard(tip: entry.value),
            );
          }).toList(),

          const SizedBox(height: 16),

          // Divider
          Divider(color: Colors.brown.shade300, thickness: 2.5),
          const SizedBox(height: 28),

          // Motivasi
          _buildMotivationSection(),
        ],
      ),
    );
  }

  Widget _buildTipCard({required TipItem tip}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tip.color.withOpacity(0.15),
            tip.color.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tip.color.withOpacity(0.4), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: tip.color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon dan Title dalam satu row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      tip.color,
                      tip.color.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: tip.color.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    tip.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Title
              Expanded(
                child: Text(
                  tip.title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                    height: 1.3,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Description - Full Width
          Text(
            tip.description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.brown.shade700,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.shade50,
            Colors.purple.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple.shade300, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events,
              color: Colors.purple.shade600,
              size: 44,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Ingat!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '"Latihan membuat sempurna. Semakin sering Anda bermain, semakin cepat dan mahir Anda menjadi. Jangan menyerah dan terus berlatih!"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.brown.shade800,
              height: 1.7,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 18),
          // Fixed overflow issue
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade500, Colors.purple.shade700],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Selamat Bermain!',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
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

class TipItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  TipItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}