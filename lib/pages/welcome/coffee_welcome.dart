import 'package:code_daily/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class CoffeeWelcome extends StatefulWidget {
  const CoffeeWelcome({super.key});

  @override
  _CoffeeWelcomeState createState() => _CoffeeWelcomeState();
}

class _CoffeeWelcomeState extends State<CoffeeWelcome> with TickerProviderStateMixin {
  late AnimationController _lineController;
  late Animation<double> _lineAnimation;
  late AnimationController _textController;
  late Animation<double> _textOpacity;
  late AnimationController _buttonController;
  late Animation<double> _buttonOpacity;
  late AnimationController _logoController;
  late Animation<double> _logoMoveAnimation;

  @override
  void initState() {
    super.initState();

    // 로고 이동 애니메이션 (초반엔 중앙, 이후 위로 이동)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoMoveAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // 선(Line) 애니메이션 설정
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _lineController, curve: Curves.easeInOut),
    );

    // 텍스트 페이드 인 애니메이션 설정
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    // 버튼 페이드 인 애니메이션 설정
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );

    // 애니메이션 실행 (1초 후 순차적으로 실행)
    Future.delayed(const Duration(seconds: 1), () {
      _logoController.forward(); // 로고 이동
      Future.delayed(const Duration(milliseconds: 600), () {
        _lineController.forward();
        Future.delayed(const Duration(milliseconds: 300), () {
          _textController.forward();
          Future.delayed(const Duration(milliseconds: 1400), () {
            _buttonController.forward();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _lineController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 초기에는 로고만 중앙, 이후 위로 이동
          AnimatedBuilder(
            animation: _logoMoveAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _logoMoveAnimation.value),
                child: SizedBox(
                  width: context.width * 0.4,
                  child: Image.asset(
                    'assets/images/welcome_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // 이후 애니메이션이 진행되면서 아래 UI가 나타남
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150), // 로고 위치 조정

              // 선(Line) 애니메이션
              AnimatedBuilder(
                animation: _lineAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _lineAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: context.width * 0.5,
                      height: 7,
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // 텍스트 애니메이션
              FadeTransition(
                opacity: _textOpacity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: const Text(
                    "단순히 한 잔을 마시고 잊혀지는 것이 아니라, 깊고 진한 풍미가 하루를 깨우고 따뜻한 여운이 오래 남아 삶에 활력을 주는 특별한 경험이 되길 바라는 마음으로 준비함.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 버튼 애니메이션
              FadeTransition(
                opacity: _buttonOpacity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    "시작하기",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
