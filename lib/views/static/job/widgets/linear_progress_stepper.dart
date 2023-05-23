import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class LinearProgressStepper extends StatefulWidget {
  final double? width;
  final double progress;

  const LinearProgressStepper({
    super.key,
    this.width,
    this.progress = 0,
  }) : assert(progress >= 0 && progress <= 1);

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<LinearProgressStepper> {
  final double height = 6;

  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? MediaQuery.of(context).size.width * 0.3;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          _ProgressBar(
            width: width,
            height: height,
            backgroundColor: AssetColors.blue.withOpacity(0.34),
          ),
          _ProgressBar(
            width: widget.progress * width,
            height: height,
            backgroundColor: const Color(0xff009FF9),
          ),
        ],
      ),
    );
  }

  bool isProgressComplete(double progress) => progress >= 100;
}

class _ProgressBar extends StatelessWidget {
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const _ProgressBar({
    Key? key,
    required this.backgroundColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 6,
      decoration: BoxDecoration(
        color: backgroundColor ?? AssetColors.blue.withOpacity(0.34),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
