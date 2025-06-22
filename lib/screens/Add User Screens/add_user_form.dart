import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/Add%20User%20Screens/add_user_animation.dart';
import 'add_user_controller.dart';


class AddUserForm extends StatelessWidget {
  final AddUserAnimations animations;
  final AddUserController controller;
  final _formKey = GlobalKey<FormState>();

  AddUserForm({
    super.key,
    required this.animations,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.controller,
      builder: (context, child) {
        return Transform.scale(
          scale: animations.scaleAnimation.value,
          child: Opacity(
            opacity: animations.fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildNameField(),
                const SizedBox(height: 20),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPhoneField(),
                const SizedBox(height: 32),
                _buildSubmitButton(context),
                const SizedBox(height: 16),
                _buildBackButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SlideTransition(
          position: animations.slideAnimation,
          child: const Center(
            child: Icon(
              Icons.account_circle_rounded,
              size: 60,
              color: Color(0xFF6C5CE7),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SlideTransition(
          position: animations.slideAnimation,
          child: const Center(
            child: Text(
              'Create New Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeTransition(
          opacity: animations.fadeAnimation,
          child: const Center(
            child: Text(
              'Fill in the details below to add a new user',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.2, 0.8),
            ),
          ),
          child: Text(
            'Full Name',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
            ),
          ),
        const SizedBox(height: 8),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.3, 0.9),
            ),
          ),
          child: TextFormField(
            controller: controller.nameCtrl,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'John Doe',
              prefixIcon: const Icon(Icons.person_outline_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF7FAFC),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.4, 1.0),
            ),
          ),
          child: Text(
            'Email Address',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
            ),
          ),
        const SizedBox(height: 8),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.5, 1.0),
            ),
          ),
          child: TextFormField(
            controller: controller.emailCtrl,
            style: const TextStyle(fontSize: 15),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'john@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF7FAFC),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.6, 1.0),
            ),
          ),
          child: Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
            ),
          ),
        const SizedBox(height: 8),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(0.7, 1.0),
            ),
          ),
          child: TextFormField(
            controller: controller.phoneCtrl,
            style: const TextStyle(fontSize: 15),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '+1 234 567 8900',
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF7FAFC),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              if (value.length < 10) {
                return 'Phone number must be at least 10 digits';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animations.controller,
          curve: const Interval(0.8, 1.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.submitForm(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5CE7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Save User',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return FadeTransition(
      opacity: animations.fadeAnimation,
      child: TextButton(
        onPressed: () => animations.exitScreen(context),
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF718096),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_rounded, size: 18),
            SizedBox(width: 8),
            Text('Back to Directory'),
          ],
        ),
      ),
    );
  }
}