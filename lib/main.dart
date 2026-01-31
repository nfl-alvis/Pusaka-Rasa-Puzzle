import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        precacheImage(const AssetImage('assets/images/Logo.png'), context),
        precacheImage(
          const AssetImage('assets/buttons/BtnMulaiPermainan.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnPilihLevel.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnGaleriMakanan.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnTentangGame.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/buttons/BtnPanduan.png'),
          context,
        ),
      ]);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading images: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onStartGame() {
    // Navigate to game screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaceholderScreen(title: 'Game Started'),
      ),
    );
  }

  void _onChooseLevel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaceholderScreen(title: 'Choose Level'),
      ),
    );
  }

  void _onFoodGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaceholderScreen(title: 'Food Gallery'),
      ),
    );
  }

  void _onAboutGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaceholderScreen(title: 'About Game'),
      ),
    );
  }

  void _onGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaceholderScreen(title: 'Guide'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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

          // Logo
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/Logo.png',
                width: screenWidth * 0.7,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.videogame_asset,
                    size: 100,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),

          // Menu Buttons
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Start Game Button
                  GameButton(
                    assetPath: 'assets/buttons/BtnMulaiPermainan.png',
                    width: screenWidth * 0.45,
                    onTap: _onStartGame,
                    semanticLabel: 'Mulai Permainan',
                  ),
                  const SizedBox(height: 16),

                  // Row 1: Choose Level & Food Gallery
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameButton(
                        assetPath: 'assets/buttons/BtnPilihLevel.png',
                        width: screenWidth * 0.37,
                        onTap: _onChooseLevel,
                        semanticLabel: 'Pilih Level',
                      ),
                      const SizedBox(width: 20),
                      GameButton(
                        assetPath: 'assets/buttons/BtnGaleriMakanan.png',
                        width: screenWidth * 0.37,
                        onTap: _onFoodGallery,
                        semanticLabel: 'Galeri Makanan',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Row 2: About Game & Guide
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameButton(
                        assetPath: 'assets/buttons/BtnTentangGame.png',
                        width: screenWidth * 0.37,
                        onTap: _onAboutGame,
                        semanticLabel: 'Tentang Game',
                      ),
                      const SizedBox(width: 20),
                      GameButton(
                        assetPath: 'assets/buttons/BtnPanduan.png',
                        width: screenWidth * 0.37,
                        onTap: _onGuide,
                        semanticLabel: 'Panduan',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Game Button Widget
class GameButton extends StatefulWidget {
  final String assetPath;
  final double width;
  final VoidCallback onTap;
  final String semanticLabel;

  const GameButton({
    required this.assetPath,
    required this.width,
    required this.onTap,
    required this.semanticLabel,
    super.key,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            widget.assetPath,
            width: widget.width,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: widget.width,
                height: widget.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.semanticLabel,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Placeholder Screen untuk navigasi
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 100, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              '$title Screen',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('This screen is under construction'),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
