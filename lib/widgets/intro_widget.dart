import 'package:flutter/material.dart';

//인트로 화면
class IntroWidget extends StatefulWidget {
  final bool introVisible;
  const IntroWidget({
    super.key,
    required this.introVisible,
  });

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  @override
  Widget build(BuildContext context) {
    //인트로 Fade Out 효과
    return AnimatedOpacity(
      opacity: widget.introVisible ? 1.0 : 0.0,
      duration: Duration(
        milliseconds: 250,
      ),
      //Stack 위젯의 맨 앞이기 때문에 터치 이벤트 무시
      child: IgnorePointer(
        ignoring: !widget.introVisible,
        child: Container(
          color: Color(0XFF682EE4),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              'OTC BOX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
