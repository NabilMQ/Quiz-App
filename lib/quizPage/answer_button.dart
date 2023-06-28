import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({ 
    Key? key,
    required this.bg,
    required this.answer,
    required this.answerStyle,
    }) : super(key: key);

  final String bg;
  final String answer;
  final TextStyle answerStyle;

  @override
  State <AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {

  late final SvgPicture _buttonBg = SvgPicture.asset(
      widget.bg,
      key: const ValueKey(0),
      width: double.infinity,
      fit: BoxFit.cover,
    );

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        _buttonBg,
    
        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              widget.answer,
              style: widget.answerStyle,
            ),
          ),
        )
      ],
    );
  }
}