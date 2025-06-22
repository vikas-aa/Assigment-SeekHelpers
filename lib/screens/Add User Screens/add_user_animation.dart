import 'package:flutter/material.dart';

class AddUserAnimations {
  final TickerProvider vsync;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  AddUserAnimations(this.vsync);

  void initAnimations() {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
    
    scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );
    
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );
    
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    
    controller.forward();
  }

  Future<void> exitScreen(BuildContext context) async {
    await controller.reverse();
    if (context.mounted) Navigator.pop(context);
  }

  void dispose() {
    controller.dispose();
  }
}