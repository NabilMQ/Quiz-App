import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelButton extends StatefulWidget {
  const LevelButton({ 
    Key? key,
    required this.bg,
    required this.title,
    required this.bodyText,
    required this.titleStyle,
    required this.bodyStyle,
  }) : super(key: key);

  final String bg;
  final String title;
  final String bodyText;
  final TextStyle titleStyle;
  final TextStyle bodyStyle;

  @override
  State <LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton> {

  late final SvgPicture _buttonBg = SvgPicture.asset(
      widget.bg,
      key: const ValueKey(0),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        _buttonBg,
    
        Padding(
          padding: EdgeInsets.symmetric(vertical: width * 0.05, horizontal: width * 0.03),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.bodyText,
                    style: widget.bodyStyle,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}