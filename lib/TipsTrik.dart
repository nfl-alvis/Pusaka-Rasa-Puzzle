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
        precacheImage(
          const AssetImage('assets/buttons/TipsTrikLogo.png'),
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
          //     label: 'Tips dan Trik',
          //     header: true,
          //     child: Image.asset(
          //       'assets/buttons/TipsTrikLogo.png',
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
          //               'Tips & Trik',
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
          //         colors: [Colors.purple.shade400, Colors.purple.shade600],
          //       ),
          //       borderRadius: BorderRadius.circular(25),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.purple.withOpacity(0.3),
          //           blurRadius: 8,
          //           offset: const Offset(0, 3),
          //         ),
          //       ],
          //     ),
          //     child: const Text(
          //       '💡 Tips & Trik Jitu',
          //       style: TextStyle(
          //         fontSize: 22,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 24),

          // Tips Pemula
          _buildTipsCategory(
            title: '🎯 Tips untuk Pemula',
            color: Colors.green,
            tips: [
              TipItem(
                title: 'Mulai dari Sudut',
                description:
                    'Fokuskan perhatian pada potongan puzzle di sudut terlebih dahulu. Ini akan memberikan referensi yang jelas untuk menyusun bagian lainnya.',
                icon: Icons.crop_square,
              ),
              TipItem(
                title: 'Susun Tepi Terlebih Dahulu',
                description:
                    'Susun bagian tepi puzzle untuk membuat kerangka. Ini akan memudahkan Anda menyusun bagian tengah.',
                icon: Icons.border_outer,
              ),
              TipItem(
                title: 'Kenali Pola Warna',
                description:
                    'Perhatikan pola warna pada gambar makanan. Ini akan membantu Anda mengenali posisi yang tepat untuk setiap potongan.',
                icon: Icons.palette,
              ),
              TipItem(
                title: 'Jangan Terburu-buru',
                description:
                    'Ambil waktu Anda untuk mengamati setiap potongan. Terkadang solusi terbaik datang saat Anda tenang dan fokus.',
                icon: Icons.schedule,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Tips Lanjutan
          _buildTipsCategory(
            title: '🏆 Tips untuk Mahir',
            color: Colors.blue,
            tips: [
              TipItem(
                title: 'Visualisasi Gambar Lengkap',
                description:
                    'Cobalah untuk mengingat atau membayangkan gambar lengkap sebelum bermain. Ini akan meningkatkan kecepatan Anda.',
                icon: Icons.visibility,
              ),
              TipItem(
                title: 'Latih Pergerakan Minimal',
                description:
                    'Usahakan untuk menyelesaikan puzzle dengan pergerakan seminimal mungkin. Ini akan melatih efisiensi berpikir Anda.',
                icon: Icons.trending_down,
              ),
              TipItem(
                title: 'Tantang Waktu',
                description:
                    'Setelah mahir, coba untuk mengalahkan rekor waktu Anda sendiri. Ini akan meningkatkan kecepatan dan ketepatan.',
                icon: Icons.timer,
              ),
              TipItem(
                title: 'Mainkan Level yang Sama',
                description:
                    'Bermain level yang sama berkali-kali akan membantu Anda menghafal pola dan meningkatkan performa.',
                icon: Icons.repeat,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Strategi Khusus
          _buildTipsCategory(
            title: '⚡ Strategi Khusus',
            color: Colors.orange,
            tips: [
              TipItem(
                title: 'Teknik Segmentasi',
                description:
                    'Bagi puzzle menjadi 3x3 segmen dalam pikiran Anda. Selesaikan satu segmen sebelum pindah ke segmen lain.',
                icon: Icons.grid_on,
              ),
              TipItem(
                title: 'Perhatikan Detail Makanan',
                description:
                    'Setiap makanan memiliki detail unik seperti tekstur nasi, warna saus, atau tata letak garnish. Gunakan ini sebagai petunjuk.',
                icon: Icons.restaurant,
              ),
              TipItem(
                title: 'Manfaatkan Hint Bijak',
                description:
                    'Gunakan fitur hint hanya saat benar-benar stuck. Cobalah dulu tanpa hint untuk melatih kemampuan.',
                icon: Icons.lightbulb,
              ),
              TipItem(
                title: 'Reset untuk Latihan',
                description:
                    'Jangan ragu untuk reset puzzle jika Anda merasa ada cara yang lebih efisien. Ini bagus untuk pembelajaran.',
                icon: Icons.refresh,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Divider
          Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 20),

          // Bonus Tips
          // _buildBonusSection(),

          const SizedBox(height: 20),
          // Divider(color: Colors.brown.shade300, thickness: 2),
          const SizedBox(height: 20),

          // Motivasi
          _buildMotivationSection(),
        ],
      ),
    );
  }

  Widget _buildTipsCategory({
    required String title,
    required Color color,
    required List<TipItem> tips,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
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
        ),

        const SizedBox(height: 16),

        // Tips List
        ...tips.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildTipCard(
              tip: entry.value,
              color: color,
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTipCard({
    required TipItem tip,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tip.icon,
              color: color,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tip.description,
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

  // Widget _buildBonusSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [
  //           Colors.amber.shade100,
  //           Colors.amber.shade50,
  //         ],
  //       ),
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(color: Colors.amber.shade600, width: 2),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.star, color: Colors.amber.shade700, size: 28),
  //             const SizedBox(width: 8),
  //             Text(
  //               'Bonus Tips Rahasia',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.brown.shade800,
  //               ),
  //             ),
  //             const SizedBox(width: 8),
  //             Icon(Icons.star, color: Colors.amber.shade700, size: 28),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _buildBonusTip('Istirahatkan mata setiap 15 menit'),
  //         _buildBonusTip('Dengarkan musik untuk meningkatkan fokus'),
  //         _buildBonusTip('Bermain di tempat dengan pencahayaan cukup'),
  //         _buildBonusTip('Belajar dari setiap kesalahan yang dibuat'),
  //         _buildBonusTip('Ajak teman untuk kompetisi yang sehat'),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildBonusTip(String tip) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     child: Row(
  //       children: [
  //         Icon(Icons.check_circle, color: Colors.amber.shade700, size: 20),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Text(
  //             tip,
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.brown.shade800,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMotivationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.shade50,
            Colors.purple.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade300, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.emoji_events, color: Colors.purple.shade600, size: 40),
          const SizedBox(height: 12),
          Text(
            'Ingat!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '"Latihan membuat sempurna. Semakin sering Anda bermain, semakin cepat dan mahir Anda menjadi. Jangan menyerah dan terus berlatih!"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.brown.shade800,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.purple.shade600,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Selamat Bermain! 🎮',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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

  TipItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}