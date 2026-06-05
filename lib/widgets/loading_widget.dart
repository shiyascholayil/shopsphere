
import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<LoadingWidget> createState() =>
      _LoadingWidgetState();
}

class _LoadingWidgetState
    extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            RotationTransition(
              turns: _controller,

              child: Container(
                height: 75,
                width: 75,

                padding:
                const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: secondaryColor,

                  shape: BoxShape.circle,

                  boxShadow: [
                BoxShadow(
                color: primaryColor.withValues(alpha: 0.15),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
                  ],
                ),

                child:
                CircularProgressIndicator(
                  strokeWidth: 4,

                  valueColor:
                  AlwaysStoppedAnimation(
                    primaryColor,
                  ),

                  backgroundColor:
                  greyLightColor,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              widget.message,
              style: loadingTitleStyle,
            ),

            const SizedBox(height: 10),

             Text(
              "Please wait a moment...",
              style: loadingSubTitleStyles,
            ),
          ],
        ),
      ),
    );
  }
}