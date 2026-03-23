import 'package:collectorapp/appconstants.dart';
import 'package:collectorapp/features/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../collector/home/collectordashboard_screen.dart';
import '../login/controller/auth_controller.dart';
import '../sdm/home/sdmdashboard_screen.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SplashController _splashController; // Store reference

  @override
  void initState() {
    super.initState();
    // Save provider reference safely
    _splashController = Provider.of<SplashController>(context, listen: false);
    _initialize();
  }

  Future<void> _initialize() async {
    await _splashController.initialize();

    await Future.delayed(Duration(seconds: 1));

    if (mounted) {
      if (_splashController.hasInternet) {
        _checkAuthAndNavigate();
      } else {
        _splashController.addListener(_onConnectivityChanged);
      }
    }
  }

  void _onConnectivityChanged() {
    if (_splashController.hasInternet) {
      _splashController.removeListener(_onConnectivityChanged);
      _checkAuthAndNavigate();
    }
  }

  Future<void> _checkAuthAndNavigate() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    await Future.delayed(Duration(milliseconds: 500));

    if (authController.isLoggedIn) {
      _navigateToHome();
    } else {
      _navigateToLogin();
    }
  }

  // Future<void> _navigateToHome() async {
  //   final auth = Provider.of<AuthController>(context, listen: false);
  //
  //   if (!mounted) return;
  //
  //  // if (auth.type == 'sdm') {
  //   //   Navigator.pushReplacement(
  //   //     context,
  //   //     MaterialPageRoute(builder: (_) => SDMDashboardScreen()),
  //   //   );
  //   // } else if (auth.type == 'collector') {
  //   //   Navigator.pushReplacement(
  //   //     context,
  //   //     MaterialPageRoute(builder: (_) => CollectorDashboardScreen()),
  //   //   );
  //   //}
  //  // else {
  //     _navigateToLogin();
  //   }
  // }


  Future<void> _navigateToHome() async {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CollectorDashboardScreen()),
      );
    }
  }

  Future<void> _navigateToLogin() async {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    // Use the stored reference; DO NOT use context here
    _splashController.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xFFFEF5F3),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: CustomPaint(
                          painter: _PatternPainter(),
                        ),
                      ),
                    ),

                    // Center content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          BouncingLogo(),
                          const SizedBox(height: 30),

                          // App name
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  // MAHAKAL
                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.black87,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      "MAHAKAL",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.5,
                                        height: 0.9,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  // .com
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ".com",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange.shade700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Container(
                                        width: 32,
                                        height: 3,
                                        margin: const EdgeInsets.only(top: 2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(1.5),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.deepOrange.shade400,
                                              Colors.orange.shade300,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Tagline
                              Text(
                                "SECURE AUTHENTICATION SYSTEM",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Connection status indicator
                          _buildConnectionStatus(controller),
                        ],
                      ),
                    ),

                    // Bottom copyright
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            width: 100,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "© 2024 Mahakal.com | All Rights Reserved",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // No internet overlay
              // if (controller.showOverlay)
              //   Positioned.fill(
              //     child: Container(
              //       color: Colors.black.withOpacity(0.7),
              //       child: Center(
              //         child: _buildNoInternetOverlay(controller),
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildConnectionStatus(SplashController controller) {
    if (controller.isLoading) {
      return Column(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Checking connection...',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      );
    } else if (!controller.hasInternet) {
      return Column(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 24,
            color: Colors.red,
          ),
          SizedBox(height: 8),
          Text(
            'No internet connection',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Icon(
            Icons.wifi_rounded,
            size: 24,
            color: Colors.green,
          ),
          SizedBox(height: 8),
          Text(
            'Connected',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade600,
            ),
          ),
        ],
      );
    }
  }
}

class BouncingLogo extends StatefulWidget {
  @override
  _BouncingLogoState createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true); // Loop karega up-down

    // Bounce animation
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: -15.0, // Upar bounce karega
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // Elastic bounce effect
      ),
    );

    // Subtle rotation
    _rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Scale animation
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.03), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.03, end: 1.0), weight: 50),
    ]).animate(_controller);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: Offset(0, 10 + _bounceAnimation.value.abs() * 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    Images.appLogo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingDots extends StatefulWidget {
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double scale = 1.0;
            if (_controller.value >= index * 0.25 &&
                _controller.value <= (index + 1) * 0.25) {
              scale = 1.5;
            }
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;

    final spacing = 40.0;
    final radius = 1.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        if ((x + y) % (spacing * 2) == 0) {
          canvas.drawCircle(Offset(x, y), radius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}