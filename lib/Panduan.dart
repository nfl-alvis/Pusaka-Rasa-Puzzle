import 'package:flutter/material.dart';
import 'CaraBermain.dart';
import 'TipsTrik.dart';

class Panduan extends StatefulWidget {
  const Panduan({super.key});

  @override
  State<Panduan> createState() => _PanduanState();
}

class _PanduanState extends State<Panduan> {
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
          const AssetImage('assets/buttons/PanduanLogo.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnCaraBermain.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnTips.png'),
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
                      color: Colors.black.withValues(alpha: 0.2),
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
                  color: Colors.black.withValues(alpha: 0.15),
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

  Widget _buildMenuButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return _AnimatedMenuButton(
      imagePath: imagePath,
      onTap: onTap,
    );
  }

  void _navigateToCaraBermain() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CaraBermain()),
    );
  }

  void _navigateToTips() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TipsTrik()),
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
    final screenHeight = MediaQuery.of(context).size.height;

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
                color: Colors.brown.shade300,
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

                const SizedBox(height: 30), // Space after header

                // Menu Buttons
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                    ),
                    child: Column(
                      children: [
                        // Cara Bermain Button
                        _buildMenuButton(
                          imagePath: 'assets/buttons/BtnCaraBermain.png',
                          onTap: _navigateToCaraBermain,
                        ),
                        
                        SizedBox(height: screenHeight * 0.025),

                        // Tips dan Trik Button
                        _buildMenuButton(
                          imagePath: 'assets/buttons/BtnTips.png',
                          onTap: _navigateToTips,
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

class _AnimatedMenuButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _AnimatedMenuButton({
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<_AnimatedMenuButton> createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<_AnimatedMenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Image.asset(
          widget.imagePath,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4A574),
                    const Color(0xFFB8895C),
                    const Color(0xFFA67C52),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFF8B6F47),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade900.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.imagePath.contains('CaraBermain')
                      ? 'Cara Bermain Puzzle'
                      : 'Tips dan Trik',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}