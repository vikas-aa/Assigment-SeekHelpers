import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/Add%20User%20Screens/add_user_animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_user_controller.dart';
import 'add_user_form.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen>
    with SingleTickerProviderStateMixin {
  late final AddUserAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animations = AddUserAnimations(this);
    _animations.initAnimations();
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the controller from the provider
    final controller = ref.read(addUserControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF2D3748),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => _animations.exitScreen(context),
        ),
        title: const Text(
          'Add New User',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: AddUserForm(
                animations: _animations,
                controller: controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}