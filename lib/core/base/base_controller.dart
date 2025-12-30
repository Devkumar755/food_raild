import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  // Private Observable Fields
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Public Getters
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  /// Executes a task with automatic loading state management.
  Future<void> executeWithLoading(Future<void> Function() task) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await task();
    } catch (e) {
      _handleError(e);
    } finally {
      _isLoading.value = false;
    }
  }

  /// Executes a task without showing a loading spinner (for background tasks).
  Future<void> executeWithoutLoading(Future<void> Function() task) async {
    try {
      _errorMessage.value = '';
      await task();
    } catch (e) {
      _handleError(e);
    }
  }

  /// Centralized error handling
  void _handleError(dynamic error) {
    _errorMessage.value = error.toString();
    // Use your custom snackbar here
    // AppToasts.showError(message: _errorMessage.value);
  }

  void resetState() {
    _isLoading.value = false;
    _errorMessage.value = '';
  }
}