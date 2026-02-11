import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Game2 extends StatefulWidget {
  const Game2({super.key});

  @override
  State<Game2> createState() => _GameState();
}

class _GameState extends State<Game2> {
  bool _isLoading = true;
  bool _isPaused = false;
  int _seconds = 0;
  Timer? _timer;

  // Grid 3x3 untuk puzzle (0 = tile kosong)
  List<int> _tiles = [1, 2, 3, 4, 5, 6, 7, 8, 0];

  @override
  void initState() {
    super.initState();
    _startTimer();
    _shufflePuzzle();
  }

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
        precacheImage(const AssetImage('assets/buttons/BtnPause.png'), context),
        precacheImage(const AssetImage('assets/buttons/BtnHint.png'), context),
        precacheImage(const AssetImage('assets/buttons/BtnReset.png'), context),
        precacheImage(
          const AssetImage('assets/buttons/KotakKayu.png'),
          context,
        ),
        // Precache tile images (01-08) dari folder nasiGoreng
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_01.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_02.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_03.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_04.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_05.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_06.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_07.png'), context),
        precacheImage(const AssetImage('assets/challenge/gudeg/tile_08.png'), context),
        // Precache gambar asli untuk hint
        precacheImage(
          const AssetImage('assets/foods/Gudeg.png'),
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _shufflePuzzle() {
    // Shuffle puzzle dengan random moves
    final random = Random();
    for (int i = 0; i < 100; i++) {
      int emptyIndex = _tiles.indexOf(0);
      List<int> validMoves = _getValidMoves(emptyIndex);
      if (validMoves.isNotEmpty) {
        int randomMove = validMoves[random.nextInt(validMoves.length)];
        _swapTiles(emptyIndex, randomMove);
      }
    }
  }

  List<int> _getValidMoves(int emptyIndex) {
    List<int> validMoves = [];
    int row = emptyIndex ~/ 3;
    int col = emptyIndex % 3;

    // Atas
    if (row > 0) validMoves.add(emptyIndex - 3);
    // Bawah
    if (row < 2) validMoves.add(emptyIndex + 3);
    // Kiri
    if (col > 0) validMoves.add(emptyIndex - 1);
    // Kanan
    if (col < 2) validMoves.add(emptyIndex + 1);

    return validMoves;
  }

  void _swapTiles(int index1, int index2) {
    int temp = _tiles[index1];
    _tiles[index1] = _tiles[index2];
    _tiles[index2] = temp;
  }

  bool _canMove(int tileIndex) {
    int emptyIndex = _tiles.indexOf(0);
    int tileRow = tileIndex ~/ 3;
    int tileCol = tileIndex % 3;
    int emptyRow = emptyIndex ~/ 3;
    int emptyCol = emptyIndex % 3;

    // Cek apakah tile bersebelahan dengan tile kosong
    return (tileRow == emptyRow && (tileCol - emptyCol).abs() == 1) ||
        (tileCol == emptyCol && (tileRow - emptyRow).abs() == 1);
  }

  void _moveTile(int tileIndex) {
    if (_isPaused) return;

    if (_canMove(tileIndex)) {
      setState(() {
        int emptyIndex = _tiles.indexOf(0);
        _swapTiles(tileIndex, emptyIndex);
      });

      // Cek apakah puzzle selesai
      if (_isPuzzleSolved()) {
        _timer?.cancel();
        _showWinDialog();
      }
    }
  }

  bool _isPuzzleSolved() {
    for (int i = 0; i < 8; i++) {
      if (_tiles[i] != i + 1) return false;
    }
    return _tiles[8] == 0;
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Selamat!'),
        content: Text(
          'Anda menyelesaikan puzzle dalam waktu ${_formatTime(_seconds)}!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text('Main Lagi'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Kembali ke Menu'),
          ),
        ],
      ),
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _resetGame() {
    setState(() {
      _seconds = 0;
      _isPaused = false;
      _tiles = [1, 2, 3, 4, 5, 6, 7, 8, 0];
      _shufflePuzzle();
    });
    _timer?.cancel();
    _startTimer();
  }

  void _showHint() {
    // Tampilkan gambar asli sebagai hint
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hint - Gambar Asli'),
        content: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/foods/Gudeg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Text(
                      '1 2 3\n4 5 6\n7 8 _',
                      style: TextStyle(
                        fontSize: 24,
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar dengan tombol Back dan Pause
                _buildTopBar(context),

                const SizedBox(height: 16),

                // Timer Display
                _buildTimerDisplay(),

                // Spacer lebih kecil untuk membuat puzzle lebih ke tengah
                SizedBox(height: screenHeight * 0.04),

                // Puzzle Grid - Centered
                Expanded(child: Center(child: _buildPuzzleGrid(screenWidth))),

                SizedBox(height: screenHeight * 0.02),

                // Bottom Buttons (Hint & Reset)
                _buildBottomButtons(screenWidth),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Pause Overlay
          if (_isPaused) _buildPauseOverlay(),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          _buildCircularButton(
            assetPath: 'assets/buttons/BtnKembali2.png',
            onTap: () => Navigator.pop(context),
            semanticLabel: 'Kembali',
          ),

          // Pause Button
          _buildCircularButton(
            assetPath: 'assets/buttons/BtnPause.png',
            onTap: _togglePause,
            semanticLabel: 'Pause',
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required String assetPath,
    required VoidCallback onTap,
    required String semanticLabel,
  }) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            assetPath,
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
                child: Icon(
                  semanticLabel == 'Kembali' ? Icons.arrow_back : Icons.pause,
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

  Widget _buildTimerDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Clock Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.access_time, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),

          // Timer Text
          Text(
            _formatTime(_seconds),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleGrid(double screenWidth) {
    final gridSize = screenWidth * 0.85;

    return Container(
      width: gridSize,
      height: gridSize,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Kayu
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/buttons/KotakKayu.png',
              width: gridSize,
              height: gridSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: gridSize,
                  height: gridSize,
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
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF8B6F47),
                      width: 4,
                    ),
                  ),
                );
              },
            ),
          ),

          // Grid Tiles
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return _buildPuzzleTile(_tiles[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleTile(int number, int index) {
    if (number == 0) {
      // Empty tile - transparan
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      );
    }

    // Format number dengan leading zero (01, 02, 03, dst)
    String tileNumber = number.toString().padLeft(2, '0');

    return GestureDetector(
      onTap: () => _moveTile(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/challenge/gudeg/tile_$tileNumber.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback jika gambar tidak ditemukan
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown.shade300, width: 2),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hint Button
          _buildActionButton(
            assetPath: 'assets/buttons/BtnHint.png',
            label: 'Hint',
            onTap: _showHint,
            width: screenWidth * 0.37,
          ),

          const SizedBox(width: 20),

          // Reset Button
          _buildActionButton(
            assetPath: 'assets/buttons/BtnReset.png',
            label: 'Reset',
            onTap: _resetGame,
            width: screenWidth * 0.37,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String assetPath,
    required String label,
    required VoidCallback onTap,
    required double width,
  }) {
    return Semantics(
      label: label,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          assetPath,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: width * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    label == 'Hint'
                        ? Colors.orange.shade400
                        : Colors.purple.shade400,
                    label == 'Hint'
                        ? Colors.orange.shade600
                        : Colors.purple.shade600,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPauseOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pause_circle_filled,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'PAUSED',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _togglePause,
              icon: const Icon(Icons.play_arrow, size: 30),
              label: const Text('Resume', style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}