import 'package:flutter/material.dart';

// ===== MODEL DATA =====
class FoodItem {
  final String id;
  final String name;
  final String imagePath;
  final String description;

  const FoodItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
  });
}

// ===== MAIN WIDGET =====
class GaleriMakanan extends StatefulWidget {
  const GaleriMakanan({super.key});

  @override
  State<GaleriMakanan> createState() => _GaleriMakananState();
}

class _GaleriMakananState extends State<GaleriMakanan> {
  // ===== DATA MAKANAN =====
  final List<FoodItem> foodItems = const [
    FoodItem(
      id: '1',
      name: 'Nasi Goreng',
      imagePath: 'assets/foods/nasi_goreng.png',
      description: 'Nasi goreng spesial dengan telur',
    ),
    FoodItem(
      id: '2',
      name: 'Sate Ayam',
      imagePath: 'assets/foods/sate_ayam.png',
      description: 'Sate ayam dengan bumbu kacang',
    ),
    FoodItem(
      id: '3',
      name: 'Rendang',
      imagePath: 'assets/foods/rendang.png',
      description: 'Rendang daging sapi yang lezat',
    ),
    FoodItem(
      id: '4',
      name: 'Gado-Gado',
      imagePath: 'assets/foods/gado_gado.png',
      description: 'Sayuran dengan bumbu kacang',
    ),
    FoodItem(
      id: '5',
      name: 'Soto Ayam',
      imagePath: 'assets/foods/soto_ayam.png',
      description: 'Soto ayam dengan kuah kuning',
    ),
    FoodItem(
      id: '6',
      name: 'Bakso',
      imagePath: 'assets/foods/bakso.png',
      description: 'Bakso daging sapi kenyal',
    ),
  ];
  
  void _onFoodItemTapped(FoodItem item) {
    // Tampilkan detail atau navigasi ke halaman detail
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.fastfood, size: 50),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ===== BACKGROUND IMAGE =====
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

          // ===== KONTEN UTAMA =====
          SafeArea(
            child: Column(
              children: [
                // ===== HEADER =====
                _buildHeader(),

                // ===== GALERI GRID =====
                Expanded(child: _buildFoodGrid()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== WIDGET HEADER =====
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
              label: 'Galeri Makanan',
              header: true,
              child: Image.asset(
                'assets/buttons/GaleriMakananLogo.png',
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

  // ===== WIDGET FOOD GRID =====
  Widget _buildFoodGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: foodItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return _buildFoodCard(item);
        },
      ),
    );
  }

  // ===== WIDGET FOOD CARD =====
  Widget _buildFoodCard(FoodItem item) {
    return Semantics(
      label: '${item.name}, ${item.description}',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onFoodItemTapped(item),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // BORDER KAYU (BACKGROUND)
                  Image.asset(
                    'assets/buttons/BorderKayuGaleriMakanan.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.brown.shade300,
                              Colors.brown.shade500,
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // GAMBAR MAKANAN (FOREGROUND)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fastfood,
                                  size: 40,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // OVERLAY NAMA MAKANAN (OPTIONAL)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
