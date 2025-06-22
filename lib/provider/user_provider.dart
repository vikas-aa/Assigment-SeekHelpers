// lib/provider/user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/user_services.dart';

final userListProvider = StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UserNotifier() : super(const AsyncLoading()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      state = const AsyncLoading();
      final fetchedUsers = await UserService.fetchUsers();
      state = AsyncData(fetchedUsers);
    } catch (e) {
      state = AsyncError('Failed to fetch users. Please check your internet connection.', StackTrace.current);
    }
  }

  void addUser(User user) {
    if (state is AsyncData) {
      final currentUsers = (state as AsyncData<List<User>>).value;
      state = AsyncData([...currentUsers, user]);
    }
  }
}
