import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_demo/provider/user_provider.dart';
import 'package:flutter_demo/models/user_model.dart';

/// Handles business logic for the AddUserScreen
class AddUserController {
  final Ref ref;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;

  /// Private constructor - use [AddUserController.create] instead
  AddUserController._({
    required this.ref,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
  });

  /// Factory constructor for proper dependency injection
  factory AddUserController.create(Ref ref) {
    return AddUserController._(
      ref: ref,
      nameCtrl: TextEditingController(),
      emailCtrl: TextEditingController(),
      phoneCtrl: TextEditingController(),
    );
  }

  /// Validates and submits the user form
  Future<void> submitForm(BuildContext context) async {
    if (!_validateForm()) {
      _showValidationErrorSnackbar(context);
      return;
    }

    try {
      final newUser = _createUserFromInputs();
      await _addUserToProvider(newUser);
      
      if (context.mounted) {
        _navigateBackWithSuccess(context);
      }
    } catch (e, stackTrace) {
      _handleError(context, e, stackTrace);
    }
  }

  /// Validates all form fields
  bool _validateForm() {
    return nameCtrl.text.trim().isNotEmpty &&
        emailCtrl.text.trim().isNotEmpty &&
        phoneCtrl.text.trim().isNotEmpty &&
        _isValidEmail(emailCtrl.text.trim());
  }

  /// Checks if email is valid using regex
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Creates User object from form inputs
  User _createUserFromInputs() {
    return User(
      id: DateTime.now().millisecondsSinceEpoch,
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
    );
  }

  /// Adds user to the provider
  Future<void> _addUserToProvider(User user) async {
     ref.read(userListProvider.notifier).addUser(user);
  }

  /// Navigates back and shows success message
  void _navigateBackWithSuccess(BuildContext context) {
    Navigator.pop(context);
    _showSnackbar(
      context,
      'User added successfully!',
      const Color(0xFF4CAF50),
      Icons.check_circle,
    );
  }

  /// Handles errors during form submission
  void _handleError(BuildContext context, Object error, StackTrace stackTrace) {
    debugPrint('Error adding user: $error\n$stackTrace');
    if (context.mounted) {
      _showSnackbar(
        context,
        'Failed to add user: ${error.toString()}',
        Colors.redAccent,
        Icons.error_outline,
      );
    }
  }

  /// Shows validation error snackbar
  void _showValidationErrorSnackbar(BuildContext context) {
    _showSnackbar(
      context,
      'Please fill all fields correctly',
      Colors.orangeAccent,
      Icons.warning_amber_rounded,
    );
  }

  /// Generic snackbar display method
  void _showSnackbar(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        backgroundColor: backgroundColor,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
      ),
    );
  }

  /// Cleans up resources
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
  }
}

/// Provider for AddUserController
final addUserControllerProvider = Provider.autoDispose<AddUserController>((ref) {
  return AddUserController.create(ref);
});